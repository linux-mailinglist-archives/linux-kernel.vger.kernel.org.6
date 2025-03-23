Return-Path: <linux-kernel+bounces-572941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0401A6D097
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6C3AB571
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A163190052;
	Sun, 23 Mar 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cWtrE2nE"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C213C67C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742754910; cv=none; b=KgDG3nFqFV3yY391HLCbxcrOR82Mihni+HIxeue7cx7m24sdxFYkJzrImfUWOAqaOgB+VAb1B2CufjD05XFeTPZ+NIvhdUucBcMdrlm4Ro8vLcdJr6SRVIwMcBCzP0MNPbAzq52MPJy8eBQGQ/iSbtXjbdKCtVPif+LHztgVyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742754910; c=relaxed/simple;
	bh=GlTGXkuzBndu2T2HjRkTw07p5/Ua+dyILEePHeWg9Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCEf/q9qMBWcVU+j7FB0U3fFO1QXgv80CJ7JqWKlO8hDDearqcp4Fl697K7JTrFpMK+3XdLQqCAMecEyKXNkDccfvZbQgh8qYwmFFIs/Vp9z1/pTOi0QjYwDfOPG8C8bWkhoz/zYLfooWikNCKb/JtaBm59xnd1j6wmK8KVfE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cWtrE2nE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CJw9Fbc7LdJCbc+45qyJljHQQZJ0j0UkTb0b5ybWzzs=; b=cWtrE2nEgKedjxGgG+cko0Oxxb
	bNVZUbC5hpGiODlAtKBJIh1x4d499qfet/y3Jy9Z0Jed8zKd9Za3QXD9nEkwG/nvvvW1WwBdtRu27
	OQEgZQTENo82DIcIr2RBRekhqLe9xYYiMCKY1W5qr9elzqb82nMBPLIU9Q0lg4/hUu/KGS9YKHfpy
	Ni6E/C7juVGdrmAOwRF2EhmZulGAm+k1CBixyKPE1AKDvNLz5t17KQhfTlnmsNsDYYEkxVKlVnFqS
	PbfEOUhmUlTRzEvy00pHpk1Dm7JZfsSFx64wFj/g0nO3YNZ9AWP3aBGkZDvW+CxsI5MoL7dIgqPSO
	j3h8glCA==;
Received: from [189.7.87.178] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1twQ9v-005N7G-4a; Sun, 23 Mar 2025 19:34:55 +0100
Message-ID: <0eae371a-0677-407c-952e-fe49bd6dae6e@igalia.com>
Date: Sun, 23 Mar 2025 15:34:50 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/vc4: tests: Document output handling functions
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250318-drm-vc4-kunit-failures-v1-0-779864d9ab37@kernel.org>
 <20250318-drm-vc4-kunit-failures-v1-2-779864d9ab37@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250318-drm-vc4-kunit-failures-v1-2-779864d9ab37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maxime,

On 18/03/25 11:17, Maxime Ripard wrote:
> vc4_mock_atomic_add_output() and vc4_mock_atomic_del_output() public but

Nit: s/public/are public

> aren't documented. Let's provide the documentation.
> 
> In particular, special care should be taken to deal with EDEADLK.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/vc4/tests/vc4_mock_output.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> index f0ddc223c1f839e8a14f37fdcbb72e7b2c836aa1..577d9a9563696791632aec614c381a214886bf27 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> @@ -59,10 +59,23 @@ struct vc4_dummy_output *vc4_dummy_output(struct kunit *test,
>   
>   static const struct drm_display_mode default_mode = {
>   	DRM_SIMPLE_MODE(640, 480, 64, 48)
>   };
>   
> +/**
> + * vc4_mock_atomic_add_output() - Enables an output in a state
> + * @test: The test context object
> + * @state: Atomic state to enable the output in.
> + * @type: Type of the output encoder
> + *
> + * Adds an output CRTC and connector to a state, and enables them.
> + *
> + * Returns:
> + * 0 on success, a negative error code on failure. If the error is
> + * EDEADLK, the entire atomic sequence must be restarted. All other
> + * errors are fatal.
> + */
>   int vc4_mock_atomic_add_output(struct kunit *test,
>   			       struct drm_atomic_state *state,
>   			       enum vc4_encoder_type type)
>   {
>   	struct drm_device *drm = state->dev;
> @@ -103,10 +116,23 @@ int vc4_mock_atomic_add_output(struct kunit *test,
>   	crtc_state->active = true;
>   
>   	return 0;
>   }
>   
> +/**
> + * vc4_mock_atomic_del_output() - Disables an output in a state
> + * @test: The test context object
> + * @state: Atomic state to disable the output in.
> + * @type: Type of the output encoder
> + *
> + * Adds an output CRTC and connector to a state, and disables them.

I'm not sure if "Adds" properly expresses what the function does. How
about "Finds an output CRTC and connector in a state, and disables
them"?

Best Regards,
- Maíra

> + *
> + * Returns:
> + * 0 on success, a negative error code on failure. If the error is
> + * EDEADLK, the entire atomic sequence must be restarted. All other
> + * errors are fatal.
> + */
>   int vc4_mock_atomic_del_output(struct kunit *test,
>   			       struct drm_atomic_state *state,
>   			       enum vc4_encoder_type type)
>   {
>   	struct drm_device *drm = state->dev;
> 


