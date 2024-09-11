Return-Path: <linux-kernel+bounces-325420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365BF97597B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A89A1C22C71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92D1B2EC9;
	Wed, 11 Sep 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnHOBHtT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8221ABEC8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076069; cv=none; b=DM/QZDQ8d+qH3ukAi1HWa8y2hH6qC6tkLCGWY2/5Gwb4AIp3AhwyYeYugBPDWbbYrYQl8xXsRVrtAtHo0HJAVmqJmswjCZKDiSsZ+hhdToY2swqVcL9u/IkCKJhRelwVmp9tUVzHd38L44HMMgtUCdCoXRSD4DC18PzGosKv3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076069; c=relaxed/simple;
	bh=nibZAFhHb4VQnJEwApYb8Jzfi7ZAKWvYOIXYOH6594E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YukHrfWVxtvfSEg2ZH1aF9arx9v3lhVZsR7Ghbk8Zlkke997HlLqZizOy8YtsQssELs8ex43Gi+ZfnXhJ5uA/AM+Efwxa7+M8BwFqff2CyjLwsgMwSCUZFQZVLiWxdTeCIZZRpH86dtpn+7xxuRl7lDjSKcmPG16zw7vmXLKb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnHOBHtT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7191f1875d3so5376b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076066; x=1726680866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Hs3sP0IaWm8QtSoZF4bycUgTm7RYb8rZnwj5x6l28=;
        b=YnHOBHtTleM8Iw85fKKHlMWTEWMvCLfi88KhXFDzQ6OGtJ7SPX6evcSmJoCP4FzECe
         h5WyjDfenoRrZhdCDGhXT9SYxO7YnecGt0Phde7/FLmaZHXicZW91rNkTiLS3jgkDt7u
         jSlafnTv2TBX04LFX4QQadRvo0BY7oyHpne0+F6GAoa7CjPYxNjLba7iWmUmolpXHsdH
         ZViJnu8h0DilfiMpM1xPtp6bIssQr5yYmXCPsXbhh1uaXeCA7+Ekrd5zd+7V9s471c3g
         qfa1HVRrSYuMnNoIzd1B6m9JlWIEYYHd9AtLMX3vmc04uXg39EimHHg5X50/9aUv2UBd
         IHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076066; x=1726680866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8Hs3sP0IaWm8QtSoZF4bycUgTm7RYb8rZnwj5x6l28=;
        b=YH04JjF0DwSbemhnarUhRJx6zhB4o85Ko1wVrxoxY1JsbV/0b8+P/lFSAFuj6TRu3W
         /a1a/QrVZdi8cBB+Xy0UeVAuroe5qNkWwBKMhIKWY/WLDG4RK2Vx44Qi3Vw/zFSuKejT
         pIUB+hzo/tQT7EEN562oW2ghilJNJqHMhFoXEy0VxgD7BxISyK/1Eu0yaAvqB2gU6V88
         vNmorcJ4hDvZ1saKdF16/e7N/7VDJPPKDw/riLPBx/YFjhLh5i5LczK4vkYzcPI5os0/
         lwEye79NRUbryHgEni9nq6hhYf2f+fD7akh0uoAMNWR6gsdd4gETANS2L5TrbkdcVVj2
         /pVw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Q85mmMsf557QbjvpF22AF0CME6xdaI2oXdvYJn503PO97kqQRzz+jaTxue2xY2HZcqc0ZACVueqb8UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVXd9Vna3xbYYTxWUZtcpvV7DEWyzuAgr3sDHQO/IJao4OxlC
	mQbscjTiMzI0ksNBbLp/26vLQDTx4mgI/ym4Ioqnsup3Llc1QlO1LfeJYqjcxFdpjMS/QEN46Ks
	UkRAggUp1fv7063CRxi26ytuL+Aw=
X-Google-Smtp-Source: AGHT+IEsHfx9RR9F1XpDKtrYe/P98LpItY1guYFun3MnIcCzCN4FO0QecDfQI2YOMVrjCp8APNdhPGll9ns6GE+FNWM=
X-Received: by 2002:a05:6a00:2d05:b0:718:e49f:137a with SMTP id
 d2e1a72fcca58-71926339ea9mr80244b3a.6.1726076065587; Wed, 11 Sep 2024
 10:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911042738.3886250-1-yanzhen@vivo.com> <024a5eb1-0255-483f-9674-dba431c01593@amd.com>
In-Reply-To: <024a5eb1-0255-483f-9674-dba431c01593@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Sep 2024 13:34:13 -0400
Message-ID: <CADnq5_O0FCHksdf37X+RxJ56SEDj9DBB3e20xft6CY8vkLGjQw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: fix typo in the comment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yan Zhen <yanzhen@vivo.com>, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Sep 11, 2024 at 2:58=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 11.09.24 um 06:27 schrieb Yan Zhen:
> > Correctly spelled comments make it easier for the reader to understand
> > the code.
> >
> > Replace 'udpate' with 'update' in the comment &
> > replace 'recieved' with 'received' in the comment &
> > replace 'dsiable' with 'disable' in the comment &
> > replace 'Initiailize' with 'Initialize' in the comment &
> > replace 'disble' with 'disable' in the comment &
> > replace 'Disbale' with 'Disable' in the comment &
> > replace 'enogh' with 'enough' in the comment &
> > replace 'availabe' with 'available' in the comment.
> >
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c | 2 +-
> >   8 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_aca.c
> > index 57bda66e8..2ca127173 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> > @@ -511,7 +511,7 @@ static int __aca_get_error_data(struct amdgpu_devic=
e *adev, struct aca_handle *h
> >               return -EINVAL;
> >       }
> >
> > -     /* udpate aca bank to aca source error_cache first */
> > +     /* update aca bank to aca source error_cache first */
> >       ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_err=
or, qctx, NULL);
> >       if (ret)
> >               return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index 189574d53..e9e599ff3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -2853,7 +2853,7 @@ static int psp_load_non_psp_fw(struct psp_context=
 *psp)
> >               if (ret)
> >                       return ret;
> >
> > -             /* Start rlc autoload after psp recieved all the gfx firm=
ware */
> > +             /* Start rlc autoload after psp received all the gfx firm=
ware */
> >               if (psp->autoload_supported && ucode->ucode_id =3D=3D (am=
dgpu_sriov_vf(adev) ?
> >                   adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)=
) {
> >                       ret =3D psp_rlc_autoload_start(psp);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 61a2f386d..71069b198 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -882,7 +882,7 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu=
_device *adev,
> >                       if (ret)
> >                               return ret;
> >
> > -                     /* gfx block ras dsiable cmd must send to ras-ta =
*/
> > +                     /* gfx block ras disable cmd must send to ras-ta =
*/
> >                       if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX)
> >                               con->features |=3D BIT(head->block);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index b8bc7fa8c..74adb983a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1970,7 +1970,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >       DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
> >                (unsigned int)(gtt_size / (1024 * 1024)));
> >
> > -     /* Initiailize doorbell pool on PCI BAR */
> > +     /* Initialize doorbell pool on PCI BAR */
> >       r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doo=
rbell.size / PAGE_SIZE);
> >       if (r) {
> >               DRM_ERROR("Failed initializing doorbell heap.\n");
> > diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/imu_v11_0.c
> > index 6c1891889..d4f72e47a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> > @@ -153,7 +153,7 @@ static void imu_v11_0_setup(struct amdgpu_device *a=
dev)
> >               WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
> >       }
> >
> > -     //disble imu Rtavfs, SmsRepair, DfllBTC, and ClkB
> > +     //disable imu Rtavfs, SmsRepair, DfllBTC, and ClkB
> >       imu_reg_val =3D RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
> >       imu_reg_val |=3D 0x10007;
> >       WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/a=
md/amdgpu/nbio_v2_3.c
> > index fa479dfa1..739fce4fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > @@ -365,7 +365,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_dev=
ice *adev,
> >
> >               data &=3D ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
> >       } else {
> > -             /* Disbale ASPM L1 */
> > +             /* Disable ASPM L1 */
> >               data &=3D ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
> >               /* Disable ASPM TxL0s */
> >               data &=3D ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v3_0.c
> > index aa637541d..e65194fe9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -710,7 +710,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_devic=
e *adev)
> >                      upper_32_bits(wptr_gpu_addr));
> >               wptr_poll_cntl =3D RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL +=
 sdma_offsets[i]);
> >               if (ring->use_pollmem) {
> > -                     /*wptr polling is not enogh fast, directly clean =
the wptr register */
> > +                     /*wptr polling is not enough fast, directly clean=
 the wptr register */
> >                       WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], 0);
> >                       wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
> >                                                      SDMA0_GFX_RB_WPTR_=
POLL_CNTL,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/=
amd/amdgpu/smuio_v9_0.c
> > index e4e30b9d4..c04fdd2d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
> > @@ -60,7 +60,7 @@ static void smuio_v9_0_get_clock_gating_state(struct =
amdgpu_device *adev, u64 *f
> >   {
> >       u32 data;
> >
> > -     /* CGTT_ROM_CLK_CTRL0 is not availabe for APUs */
> > +     /* CGTT_ROM_CLK_CTRL0 is not available for APUs */
> >       if (adev->flags & AMD_IS_APU)
> >               return;
> >
>

