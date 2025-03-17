Return-Path: <linux-kernel+bounces-563742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C768A6477E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C9116F3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C221D00E;
	Mon, 17 Mar 2025 09:33:38 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F052F30
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204017; cv=none; b=iGgAIDTnRx7VjNMtpgKYBVSD/08fyDuReN+mNX2vE3jX2rK0bDMwqjrFA/alfXZ1Exceld6EZ47102zTUT9tSB86BdzMc8WWiNnkgcmIMKVnbSTuDEynrZbw7m5gyYIen+Dg77mQNoIrC4t2DqzXv6zYV4nVzludgfzs1YcQOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204017; c=relaxed/simple;
	bh=PsxOrzlFjsxLHkU08uV+9uzcvP6uOPtUFDuXDdC98FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln7vb9JpxFWcjpXXQHapZbondHHH9hyuOWNv3YjJdJlkh2JuHa8VcxIB1hF9KFZgJeWRpLw9Zi9wQ5qhikmugHcuS/OoaAnS9YD/RQgRIBiIGMWj9oY22F6orSq+EftYjtPIG97YAPaWJy38bDDr6Kq2n4WEYZPAuzy5NVqLPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac298c8fa50so783931666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742204014; x=1742808814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fJo5zDfQ4kPxJxhSWnaEAAlNYVAeESKJdwbB4zuW30=;
        b=uWe3qBMC0l3Z6Xbm0h3aLchpOrRg8X7qMMKEpEJp2TtmMLAi8GnmSEusAnOpwMbeN+
         rkgehFo4pQZF+C19Hx1+a9J6CdOuCoDJ88RpZqJK47jV41A/Gn00SgkvmpCV1EUNHx8/
         EQzTCjfTx6PrB0TS+KNpWwkJVq+2nhIO07TU2v/rzDx+zWz0Fvh1KUYWaecmSzr2mFLy
         HyQhz6GMThC+5Iv85TwcL0Z7oj/ko9pxcxnAnI/sJKPKtotCOuOTcGjKsB8q/IO7FAXp
         CWEdGPVi4H1xR1iQTBor4uYKpy3nFZz59Zh7GOckjCdo99bAox+n8RJY20NrA/qRNbzF
         N1gA==
X-Forwarded-Encrypted: i=1; AJvYcCXcfDqbX+65P6YWdRVEft1/CKwSdvKjLmUmGHPMQbrg70HtlZf+Agkvt7D1QCDMENU7eUI4kHiHzX99R08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJokGADuJ6Rob9jGwX43DlSqicgs2KcA4CP1tahXYz4vvuBIH
	EOssuex75+CDB+qTTNS5R7BJtpaB+ZcIyu79Q+f4nFi6l6EeF5Za
X-Gm-Gg: ASbGncuJtbns2liucn8VA7u3rg1U7APR07/onriLDj0BmwiJEdi3FpH4p78KzhkR5ug
	Oj+m99giFtMs4MmlmkmngVeBhUEKPGOVlzvxDRhjsRzr6Asn0AVLmuHgFu7lUwtRsbVB0EuZujA
	lAymjFcYsKtwQyQXnZJ2hHI0qqkpIDNlUql1gU5X5ExCTI9Em1CeP87uaZ/Ndmw2/jkzd/kd3mT
	QWiu2QXXYPzLPBDRwuPBWGxE4oEgjoGD/cFUiIyeeeCi/QIqZ0iVp60I5BMPDDgVm/liayR53Yc
	kb6DWsV26jjqlgGuh3DqBHoKmJAqogRypAE=
X-Google-Smtp-Source: AGHT+IEZjdu1qY0Y6OW9fEkhQiS+SDaBPSurXGqMA9oKwTei2mB6At7OaEeooZeORXPojtqE9DT9AQ==
X-Received: by 2002:a17:906:1f52:b0:ac3:4491:5079 with SMTP id a640c23a62f3a-ac3449151demr778533566b.2.1742204014263;
        Mon, 17 Mar 2025 02:33:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169bd543sm5753635a12.45.2025.03.17.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:33:33 -0700 (PDT)
Date: Mon, 17 Mar 2025 02:33:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Rik van Riel <riel@surriel.com>
Cc: Corey Minyard <corey@minyard.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] ipmi: fix suspicious RCU usage warning
Message-ID: <20250317-horned-nano-degu-a6e5bc@leitao>
References: <20250312131932.44d901f7@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312131932.44d901f7@fangorn>

On Wed, Mar 12, 2025 at 01:19:32PM -0400, Rik van Riel wrote:
> On recent kernels this warning fires:
> 
> drivers/char/ipmi/ipmi_msghandler.c:1238 RCU-list traversed in non-reader section!!
> 
> This looks like a fairly simple lockdep trigger, where
> list_for_each_entry_rcu and list_for_each_entry_srcu are
> functionally identical, but the lockdep annotation in
> the former has an extra check.
> 
> That extra check is whether the RCU read lock is held,
> which is not true when the code uses srcu_read_lock.
> 
> Get rid of the warning by using the properly annotated
> list traversal macro.

Thanks for looking at this one.

There was a discussion about this issue a few years ago, with
a different approach that never landed upstream.

	https://lore.kernel.org/all/20201119123831.GH3710@minyard.net/#r

