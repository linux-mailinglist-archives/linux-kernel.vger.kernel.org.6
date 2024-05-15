Return-Path: <linux-kernel+bounces-179693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB08C637B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA8A1F239BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3557C9A;
	Wed, 15 May 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZLoyObm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454E56B76
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764525; cv=none; b=rRS33eAAUwH0EiOYJfhqgyBhv6xoIUgXMBoXW10j8ux3XwQpQwCEg1zoJdfd47+WRv6vuSH/eqCXQFf05AzRv1THpgua/qbKBelBo9iIniQOVEK5n33oawZeqB2DpRYj4MvCAGoEv2GmMx5mMsjQdlH4R+QMhtu3xXQxvyTSODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764525; c=relaxed/simple;
	bh=P/HmKa64i6J06kGw4UB/yDL2SRVNBtVvTV8ov96LlWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe6F0Q58krwkiqxS1RLC6a/Zv5LnXLcq+mCHkcjDXFOswmNIrVDtyc7K6SCwX4CDGsvoFbU1ByVc7R6Wnkk8qGwGO8XQ80bnLW9eAfMfIURCpqaQGznA3tIM4MNQnerWmUALJgkB0FdOu/ITm1ks9Ctg+26vF7vDSTP5pKCK/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZLoyObm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so19919835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715764522; x=1716369322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/8H4twMQ08jXWD/He9ul5nNDZsvIBXg3kfowyA9eX0=;
        b=iZLoyObmt2Yca5UrDril2Lx0dViZ2yEdpFWDCPcsmZCYkANPjMucc0xlmVKhAbuBe6
         iDbUQ5spzmw2Z7UOqKHblzgtRa8FJqRWnWdhOoTGZAfMtCRQh7e0QvEGzSmBmm1lYm3H
         jYpqHRkbpL+v12tsHTmfr94KL1RUFABrIDRz8ukHNj5W8AECHJTPLiBW/i7KrSoMO0jY
         ChvtOg6+iXdYJPD2rV4APfcAkoXt36lHjc8Mc/k5ewONmeOOQ7i08dD+9ok7djTlYz03
         B6qeBlWN0C+EmRnmLQT3rvNjNsHpVLcG8oIbA9B+mw8trg9rwX23tILvSh3Yz8iYqZFr
         xAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764522; x=1716369322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/8H4twMQ08jXWD/He9ul5nNDZsvIBXg3kfowyA9eX0=;
        b=EYNGi3bRL9QefqKgAmMvQgQrSzFbwghcb+dotbVIcO5vOLZXiisFGTYmfDtgMyngEm
         aMu7Gu/CrCLHvLfErGVhfZ5/IYOu5YJnt5N1DtXM0um01vmdhlcJVXbhIkHj7i0RkZs0
         bvrzw9/C6dfp7FaP8DhBN9T7rO2ZZ+vUSRWZgCyolF807lixJ+mTDtq9ds3dnlpCRa0/
         iPWhTh8VSzRfstoOknv4rX5xGszFQAa1aRjkJs8PX7hCgwUQ3hXKKaGRDx7mb72DDuHK
         7xqEI55Bh0S/oTBYytmZ5KU7IThA+n2AQSKJcvq7tQctAHaKXrCeMp12n/9bAYjXrG2Q
         r4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrnb7N3hAHJECJyvLQEpEAANT70orfYd95MGAPHgLMtCmIa9AhGpBz8qhgu1LjoyJTwpI4fU3N6KFYrP9/HNiJzWhQuGNBw17go6Pk
X-Gm-Message-State: AOJu0Ywn8ZyleQAtoFyFrvkXOnFmWsTwhHDWOQXTsG5OnxAm27PEdWVl
	RkTVrDtOk92BEU29Qtw/5BUAImXT4NPo6+ny+YPmWLAFi8Jyd43o8c3dLR5geSA=
X-Google-Smtp-Source: AGHT+IFqalPaSl4AAIIgaEheMCKHyeisFKgxUKzweu4wr8Znn5IvAhWOarmgR7VH45Doqs/ZLZXWvw==
X-Received: by 2002:a05:600c:35c2:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-41fea93afeemr126972175e9.4.1715764522013;
        Wed, 15 May 2024 02:15:22 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8969f0sm15991078f8f.28.2024.05.15.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:15:21 -0700 (PDT)
Date: Wed, 15 May 2024 11:15:17 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/31] Staging: rtl8192e: Rename variable pList
Message-ID: <b1463844-537d-4836-bcaf-8eee868bd799@suswa.mountain>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
 <20240515045228.35928-17-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515045228.35928-17-tdavies@darkphysics.net>

On Tue, May 14, 2024 at 09:52:13PM -0700, Tree Davies wrote:
> Rename variable pList to plist
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtllib_rx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index 30bd6f49e915..fb679229f173 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -406,24 +406,24 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
>  static bool add_reorder_entry(struct rx_ts_record *ts,
>  			    struct rx_reorder_entry *pReorderEntry)
>  {
> -	struct list_head *pList = &ts->rx_pending_pkt_list;
> +	struct list_head *plist = &ts->rx_pending_pkt_list;

The p stands for pointer.  #ugh

regards,
dan carpenter



