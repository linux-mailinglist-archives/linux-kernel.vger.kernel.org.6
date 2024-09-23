Return-Path: <linux-kernel+bounces-335814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E045397EB16
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC74280D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4C433D6;
	Mon, 23 Sep 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YateBYjH"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE031974FA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092373; cv=none; b=JE0SpZTsQ1TFT0KX6z/ONHRjOIZr8Q0Qh2tccOOAnv/Sjv/I3LQ0e6T1JqNIWbQJqa+XalOqJQhETjOTaLhZ2xp4xcygnvYUDcsDmqM5nBP4rgg3WLz8d82+r51Jn3jnRtZfCIT7sxvSrIICLL/UqIdVhuKH8klTuJOTVAH19bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092373; c=relaxed/simple;
	bh=HZTG+GQe52jS6g5Tcq06PZcX/VJwn6XsB9avf7KWn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ4ZIgleMHuw8leqtclgO3CxZFiVUc9uhavHWOjnebVVv6f4J7pjXQoklTWywyZ62joGT5/Q1Ldx2ged/2N8N/vQ3nODxWk6zq+Q4aaYi3A+jzMwaF7FIEYAHvhNsA8mQVgzulmE3jJYJnNW/0s9JYACUAwjNCqkt98dQU7SvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YateBYjH; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e201f146cc8so3772697276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727092370; x=1727697170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=YateBYjHOHSWxRV1t2MxnJmlOFpCzBtukb9MpkAGPlTCRIZQvfoGWiS3m6FohcDJWF
         dGRm/mIlTTBk+M8bFRrObWfaEHIDkgnyqSUizo0FPvAWKEXXcyhqaCMX2kQakPK3i+kQ
         O/AzsbRZRrmSMcYBSMnx/MewVH5EvR9m6Y1Q+wuEGCk9fJDzyyU1WLlP1bd7dr2oMzqU
         l9lrbLJPWLV0SdbU+3K5ACxNwp1rFCaDkkVZriWE+r2zh9lcPZnmRjj5DdTsj/LB8ySt
         bsv9zH9UoztlApSnJP5uaJCldD/gXoAYrMUkrck1ZHHa6+z1zob/L/aCtbSbWmBh1ABr
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092370; x=1727697170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=nz8S4nVpuc2dzxlDEc0hz2qoaxjSgj4Vpy9hC9GOc+4NrRsjQoKMhOXC/oTXwUS17N
         tu4zEcULIS497Bd+i4IX/OynVk2W0VXGRpc4nFcIsIlZMKgVFFYQzckv8YxjmfTMGRM8
         FEZcHtVSgYbT8JIcTAXai3TZVAl73NYxMl1LMF8Eb/d+V4GCqYipSbbDeOWv0GWhhuec
         JfqwLmggnjHZBjizOcTihRplKbrPLxmK5pDfIHlet/G7Ljj5GvRp37u9N2AcsR4bGEF7
         nPyy4ys0uSyq3NA8BvPR2O6WYFhGSguDIb7UNfL8h2VJ3bShprMnvBPATmgkcTRrJb16
         kd6w==
X-Forwarded-Encrypted: i=1; AJvYcCUUx6WrGP647HWj39SfY7KwgwL/YNm60SqZTqoEkKu3pH5UUDpl6uzOhgYs83Xrrrfb1EF7qd/6JoAbVeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3QrDLkibVVKKqq/WOzxqJTLNUrpy45ILlFA6KKhY8lYHWr8+
	MNKaIy3AUgE78Gc22VQwgHisKrkOjyKE5yQs5goHP9mriZaRd5kH3JzXkPlG86wbXmij5pja3tK
	7NqcL4MjqId6TEkbiteIEbOLCRCZvT+NJS/Oh
X-Google-Smtp-Source: AGHT+IH67k8daKEYTW3HHmz6negW5CiPM7iyxdQ5CKiRgxjRoq1/X/Upes8Q9bMpCpOlddu//dq56AyXXaFan3/oJXs=
X-Received: by 2002:a05:6902:248c:b0:e1d:2300:29a1 with SMTP id
 3f1490d57ef6-e2250c5483bmr7783067276.29.1727092369977; Mon, 23 Sep 2024
 04:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 07:52:39 -0400
Message-ID: <CAHC9VhQM7ingdydXFZ7Mt9FHLc4E1q7Mg_FR7FbFajw068TBig@mail.gmail.com>
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:08=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> add a comment to doi_remove in struct netlbl_calipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 529160f76cac..4afd934b1238 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
>   * struct netlbl_calipso_ops - NetLabel CALIPSO operations
>   * @doi_add: add a CALIPSO DOI
>   * @doi_free: free a CALIPSO DOI
> + * @doi_remove: remove a CALIPSO DOI
>   * @doi_getdef: returns a reference to a DOI
>   * @doi_putdef: releases a reference of a DOI
>   * @doi_walk: enumerate the DOI list
> --
> 2.34.1

--=20
paul-moore.com

