Return-Path: <linux-kernel+bounces-420363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD429D798A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81333281881
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E4B66E;
	Mon, 25 Nov 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euOJKyAj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351744A06
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495987; cv=none; b=Msomf7NUTzYyWu5zbi81TUMXz/k3ZkUpk5Ut9VUM9pbAgqesOmoNS8Am0mQaC5rHU5uYXfT6Nie2eeWtxRKSCWl/cfJNbW3frxGFRrw7+xbY16lvnACdDoSU0JDNEpnyyySEk9mMBV+iPtQnyRQhOKWktiRchBuzNSlbCbO/w1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495987; c=relaxed/simple;
	bh=LviZfhN9wLHGkGwdTJsxWo+fyXaKifA70nBROdiPnBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1pBEmAnCCup0FjyuWilG123vDgvbIPmgqwJLm174fStpbpj83mNAxBM2xB1fAPhRGsUO/9andkNmA7LiZ5KAYhJoAAdFafjiI4dE2+r5f0Kbq3VZPK9IdSKMgZNnPubhWRxkMB0o6T0MsomC3tuG5aWuSyM+eNxUwXPbvMVYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euOJKyAj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732495983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Og/rRZZnoc2/FOYWx0+cNvJMuebsJiZG18iFWhHEBpQ=;
	b=euOJKyAjgnKNeCoERNwgHrF8NXVyJlmnJWidR5PAopznFg6KNY4rcNrUlF3Ss/+PqrOw7S
	zwnFSL9SyJ0GaLfj7dYB0crkxLmLNZgGu3a1qW6fPf6CTvOsDRiWMZwmMsOaHoSsZ3DdBt
	c8hAHQkUr9Cs5ylvPn4ullA7nr+jFAo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-nQxrCXa9OIC6DsV_Plja-g-1; Sun, 24 Nov 2024 19:53:01 -0500
X-MC-Unique: nQxrCXa9OIC6DsV_Plja-g-1
X-Mimecast-MFC-AGG-ID: nQxrCXa9OIC6DsV_Plja-g
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7fc2dc5861eso447136a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732495980; x=1733100780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Og/rRZZnoc2/FOYWx0+cNvJMuebsJiZG18iFWhHEBpQ=;
        b=TUc4XZ+rC5RhRpaYFeNUYoF4oH6ClyFs6eu6/MJbLu6MP3BTwdUzdAGuv8nFtDzeYG
         4HYRP036TQ7Rsbd5aEmoIZzDOM0f+3qJ5lf+vt63SDPt3O5KWm/oG9qISEZXI6XlRRUJ
         +txM/m7o11AQAjVYD7wWrQizyyoF6iH5CEs3u/Dc17jtTp8ML9bWYcTLmtnAF4yEZB1R
         pygcE1enhQpg5t9uMN3i8VuKqOORp4+fi4tcC0ztVt1+w7CMupLTyzXd64re9QRwAFAW
         5Q7WYV3CrZa/HhvNjSXsqNTZfQ58tL7Vj6OOmUCDCNcJ8k5rDxtrsQ4nEuS9M8NpOdK1
         I/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHBfjQcXKRtfpF97I7zT7QOQFjeWLwW74V+koaPeKs1MiGTddYi7RNU/6YHMDRuxPlnrlBYV/PBWxuk+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrFl2+0zt/aM6ueIz2j1+vaTjgfEYm63O7KE8bsQ216nrCtxv
	uxOolMGeJkDIcGZ8eHV72vvPWIzRTStkPPK1fQ0bsJBMVlW47SISvo/EUzCZVlBuBwRnNNPWF8X
	AnCU+1ccnjppMsF1z/8kfqwgLxDgni9Zy/tJjaZ8yUv3sl0Opwp3H7NUudaWtBg==
X-Gm-Gg: ASbGncvgT2nUmWTBkdf+nGnpAbolE1vfJfjmeAhKuR4zB3wnsRaQjnrFAMDkERRz6zK
	wgZK0dzAiuA09U/2tuk2GBziY9YSC3hcycHUFhhwqu0x09X/F/gcaCY9UBhLsfVfQX77EA2aD4H
	UkfjJgm628BZe62Fx0EBV1XA4fjo9al6Zg1MWanEZ+ZAvxuhQsAwhdFrOgSTCzvYx7sYnSm5EP2
	hJ+u3Yg8/Ihz8kG6fKTZtDLe2g1aEQmUJlwqShOglm4ZiNlSrU=
X-Received: by 2002:a05:6a20:1582:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1e09e3f0006mr15957941637.10.1732495980442;
        Sun, 24 Nov 2024 16:53:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6wfZGq3UlSemEP5dLQviUNWOYLTc9QXIUBc6PDL2mjW5iUJ01qPTCvrL0lGUH2zBWvTRnRg==
X-Received: by 2002:a05:6a20:1582:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1e09e3f0006mr15957929637.10.1732495980195;
        Sun, 24 Nov 2024 16:53:00 -0800 (PST)
Received: from [10.72.112.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47d4b7sm5176803b3a.46.2024.11.24.16.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:52:59 -0800 (PST)
Message-ID: <32d12a9f-d2c0-45bd-9f9a-e647a2ac7083@redhat.com>
Date: Mon, 25 Nov 2024 08:52:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/ceph/mds_client: pass cred pointer to
 ceph_mds_auth_match()
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241123072121.1897163-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/24 15:21, Max Kellermann wrote:
> This eliminates a redundant get_current_cred() call, because
> ceph_mds_check_access() has already obtained this pointer.
>
> As a side effect, this also fixes a reference leak in
> ceph_mds_auth_match(): by omitting the get_current_cred() call, no
> additional cred reference is taken.
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/mds_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 6baec1387f7d..e8a5994de8b6 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5615,9 +5615,9 @@ void send_flush_mdlog(struct ceph_mds_session *s)
>   
>   static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
>   			       struct ceph_mds_cap_auth *auth,
> +			       const struct cred *cred,
>   			       char *tpath)
>   {
> -	const struct cred *cred = get_current_cred();
>   	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
>   	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
>   	struct ceph_client *cl = mdsc->fsc->client;
> @@ -5740,7 +5740,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
>   		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
>   
> -		err = ceph_mds_auth_match(mdsc, s, tpath);
> +		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>   		if (err < 0) {
>   			return err;
>   		} else if (err > 0) {

Good catch.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



