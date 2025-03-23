Return-Path: <linux-kernel+bounces-572931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA1A6D081
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A90818910F5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A121624D5;
	Sun, 23 Mar 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kmnVozqf"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C4802
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753299; cv=none; b=c8zMRlXyqOAT5WatorUpo3CsZcrF/ko2w9guOpM3g/324kWeGUqQKX0SqclVlg9j6UPriiNqWPksTGI4MV6cYwya6mTnJHCmHgG0/3oziNYVFD95Ijs99DjE+ldnBhHpqx1VXhdftBBlk8qJOfoNG7nKpXaezjVxXfZYC7dT25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753299; c=relaxed/simple;
	bh=Ogpo3ymYD2U3EI+FubcLXjYZrTNlJSfprYiQ6vgCN4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkOcylD2PUD8OcuphpKfcACeguuzsYulL7nkgsKdSV0X0NM/fPopRnSrlGZuOqBfLK6bC3yswjDfZI9+/Bikb9O8GeQ3wCt5XzcPlSctJeQYz+DELUNmLGqRNOBcT7U4e12CHnQF1XwMEPpIRMA6JoxvMv6SKlYvi9IlskK5Pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kmnVozqf; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D77nPsmMV0/TxqLnhHvNQ9fX2PYMvK9BF/KPlrJlvuM=; b=kmnVozqfsnzzzJnDGNN7L7dXUw
	tOkdCO7OjaTQsYv35ngVffKY6u08v/vfqhSoVBci/QuGs2X5A0z/yxElqHhtVvc9XtuWWRXihM82f
	+T9GoJscUeQJhZzi7ctoxfI28+/KSuRcOS+1QY+YV+0SgLv+xR4p5ygWA1ayIUXSH1t6kV8NreBft
	qpt/SM4aaLK9La/xo9mEGDUDHmtOAb/nfx7Rtg/Gb17fBW2nFJaRrM2q33FcQaB+YLnmHI4p0J2O3
	EntZigfC+cnKOIlG615hRLbAR1CSsmUkG4sIce5kmPmzeloFGAaADJCYj7JRKf2Crzh53fkjLS12p
	13OoREkA==;
Received: from [189.7.87.178] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1twPjx-005MlC-V0; Sun, 23 Mar 2025 19:08:06 +0100
Message-ID: <e3517bd6-a9c2-4193-92d8-b6510b967d0a@igalia.com>
Date: Sun, 23 Mar 2025 15:07:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/vc4: tests: Retry pv-muxing tests when EDEADLK
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250318-drm-vc4-kunit-failures-v1-0-779864d9ab37@kernel.org>
 <20250318-drm-vc4-kunit-failures-v1-4-779864d9ab37@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250318-drm-vc4-kunit-failures-v1-4-779864d9ab37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maxime,

On 18/03/25 11:17, Maxime Ripard wrote:
> Some functions used by the HVS->PV muxing tests can return with EDEADLK,
> meaning the entire sequence should be restarted. It's not a fatal error
> and we should treat it as a recoverable error, and recover, instead of
> failing the test like we currently do.
> 
> Fixes: 76ec18dc5afa ("drm/vc4: tests: Add unit test suite for the PV muxing")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 44 ++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> index 52c04ef33206bf4f9e21e3c8b7cea932824a67fa..94e05bddb630a79aab189d9bc16f09a9d84ce396 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> @@ -685,20 +685,26 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
>   	vc4 = priv->vc4;
>   	drm = &vc4->base;
> +
> +retry:
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   	for (i = 0; i < params->nencoders; i++) {
>   		enum vc4_encoder_type enc_type = params->encoders[i];
>   
>   		ret = vc4_mock_atomic_add_output(test, state, enc_type);
> +		if (ret == -EDEADLK)
> +			goto retry;
>   		KUNIT_ASSERT_EQ(test, ret, 0);
>   	}
>   
>   	ret = drm_atomic_check_only(state);
> +	if (ret == -EDEADLK)
> +		goto retry;

Shouldn't we call `drm_modeset_backoff()` before retrying (maybe
`drm_atomic_state_clear()` as well)?

Best Regards,
- Maíra

>   	KUNIT_EXPECT_EQ(test, ret, 0);
>   
>   	KUNIT_EXPECT_TRUE(test,
>   			  check_fifo_conflict(test, state));
>   

