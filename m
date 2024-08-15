Return-Path: <linux-kernel+bounces-288054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45CB95324C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FBBB23EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF081A01BF;
	Thu, 15 Aug 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FtebDymT"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A01A01B5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730566; cv=none; b=gdP5B4Rnmwx05Lje/vMJeok7AJhrONfkdMt2wY4/EyCM2j2KbOuCMdmbQcyKBOuzgJvYPGKtGRjuEouIbCOCwWYr+/Zevr8WnH4YD6Y2l9SnpDV1wXFp/4op9uajjgRHhdsVVZD90AGK1YuFB+gkMs1T7v2Ct0CFs6eMQ3wz2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730566; c=relaxed/simple;
	bh=HvkBdPTZ6+bfJZFfiC1cb+NSD8JcwXHyUSoeViYbVcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtmkQIn7pLMKNGL0CQBRUfqEJILV/0RvHVmx2iCwSbsVl8axAiugO3Edo3NRDbK/6Jqc3jEt729W05d9AmZ7RoxRur2NNCfa+UrHck6qjHhTBQfoVCW2Nn6wGJj+pJNqxGlclhhwtrh1WkjcVis8rjRrIxngZQuM0bc/5cgpNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FtebDymT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K+dMu/AHRYE1Qvp4JgBkCWHyyxJUUAXm9hxfkstQBvU=; b=FtebDymTH5WjFbVKuQ0C32Y8rh
	iGNPN7D8KAra4Wpi4RV51nmvOXmWDJ6R9roF6srK4kQgMNiKg5ESJU30uZqvgbDTj4+O3xNV17UZP
	5hB2Fx399IyNHctv6io8hnvUG8dP5OJYLVKkNQBEyGx5Fjd/3C3+zgZCU3EFFaJAVpIBWBISBbseP
	eIQ0dD9VbChgOS0ePSp1/c+VDYlY2exOmfm2AYLL1afF8jJn/aLA5ccuEg24avlDmHdiN6zQPrMPr
	4fsX55D7Qr6qQx2KDG19Y4sX7ZvsNrAhRHgN2hz1uzvah7hFNtXc75H9X1BmIUJ16a5P/X3Xz46hc
	wbbhYPhg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1seb3N-000dlz-EV; Thu, 15 Aug 2024 16:02:13 +0200
Message-ID: <909b3739-5470-41ae-a5bc-420b701b158f@igalia.com>
Date: Thu, 15 Aug 2024 11:02:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/vkms: Miscelanious clarifications
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 8/14/24 05:46, Louis Chauvet wrote:
> This series does not introduce functionnal changes, only some
> documentation and renaming to clarify the code.
> 
> This series is based on [1].
> 
> [1]: https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/

There is no need to base this series on four other series, as these 
three patches are completely independent.

Best Regards,
- Maíra

> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Louis Chauvet (3):
>        drm/vkms: Formatting and typo fix
>        drm/vkms: Rename index to possible_crtc
>        drm/vkms: Add documentation
> 
>   drivers/gpu/drm/vkms/vkms_drv.c    |  6 ++-
>   drivers/gpu/drm/vkms/vkms_drv.h    | 85 +++++++++++++++++++++++++++++++-------
>   drivers/gpu/drm/vkms/vkms_output.c | 23 ++++++++---
>   drivers/gpu/drm/vkms/vkms_plane.c  |  4 +-
>   4 files changed, 94 insertions(+), 24 deletions(-)
> ---
> base-commit: 219b45d023ed0902b05c5902a4f31c2c38bcf68c
> change-id: 20240520-google-clarifications-dede8dcbe38a
> prerequisite-message-id: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
> prerequisite-patch-id: ae2d8b2efbbaa9decce56632c498c87e708288b3
> prerequisite-patch-id: c26b6d4867eaf6566195aa0002765357d4f69f8c
> prerequisite-patch-id: 8791d34a6f3148dc518da5249453067e40d346e3
> prerequisite-patch-id: 26ec7cd5a449004bcfd6ce483671f87655f8635c
> prerequisite-patch-id: 2e855ba871f2e99d4b6b7d85da2ddac6bb32262e
> prerequisite-patch-id: 82523a917646793deeec7cdcc7ff286bd924fd21
> prerequisite-patch-id: 0e355e5316281f53ab5e97ab6e63b0a682f3eb9e
> prerequisite-patch-id: 7a63d245a377d5f5283f48e8f52421b912811752
> prerequisite-patch-id: dda6bf4692cd1795c489ff58e72c0841ea8ffbc4
> prerequisite-patch-id: f70e535b6086cc587975fbfa75741f485f679a32
> prerequisite-patch-id: 6c2aa2645c7d854951608aa4d15a02e076abe1fe
> prerequisite-patch-id: dc61c6d3db73053fc36e115af561e0c42b467de2
> prerequisite-patch-id: deda292af6d8bbf6762b0bf4d351ffd2225995d8
> prerequisite-patch-id: 18554f49b53cbcfd4a8ca50dc83b17dd3cf96474
> prerequisite-patch-id: 5633292e10132d29be2467812e6e2e824cfedb67
> prerequisite-patch-id: 43f37e9c1bc041d491e41dfb59548ed258a1e071
> prerequisite-message-id: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
> prerequisite-patch-id: d10db4cb12a88de2e5f6440e9fcf5ddda191e3cd
> prerequisite-patch-id: 16bac0ef1f1dc010a72ce2faae66631797d23d3f
> prerequisite-patch-id: 8e0e5cc0727e8fd2d14ebafc5538fd987c2dd38e
> prerequisite-patch-id: 32bad3bf3df46d042e9edd4c1259c2e2a3fb8975
> prerequisite-patch-id: 4bd9e4cef308abd17b7b274a5575a3de73a1503b
> prerequisite-patch-id: a98fac5a2c60fe23fbc6a455e9a4ab8b0f187ee8
> prerequisite-patch-id: 62c8d109a22b9978f755255b67f13fe74fb7008d
> prerequisite-patch-id: baa8da4871dd90b03a07c6d9ddb45e10929ee70a
> prerequisite-message-id: <20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com>
> prerequisite-patch-id: df699289213021fa202fcdf1b4bdff513d09caa2
> prerequisite-patch-id: 59d021ccb166fbe2962de9cda72aceb3caa9cabe
> prerequisite-patch-id: 895ace6d58b3776798791705b7b05e26b8d37c7b
> 
> Best regards,

