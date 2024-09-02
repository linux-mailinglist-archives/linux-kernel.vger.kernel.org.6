Return-Path: <linux-kernel+bounces-310530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B4967DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6705128248C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42E381AA;
	Mon,  2 Sep 2024 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+OXubIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7F2CA2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725245303; cv=none; b=niwx6yeVKXa5nTGj9Ibn74mu7uOAb9ck/ahRZ5wvxZ0TFElqYwgIscDw/4KEVSi+0sHDShFdF5SlR1PWRs6WQE+1WnaNGPkFG4thLYdi8YXinY+U7brQ+uLPxpGqHODyGTt7hiPu9LoNEN+D8goPdKcz6K4xJoo/u2toXZZoWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725245303; c=relaxed/simple;
	bh=mgNfDILZHBYUOaB8Di9zjgdUV7oi+Y+swUQl7vuMQOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ2YgBrTcfGehImla6wmb9NXQz+ZsZG0teIBuJ6fTBA5KB55wg5HuFpvhdT6fkyLVgtKb9CdJ3h497IlEhU7IzGuBWFXsQAjn5o7tw51igGi135WID70Lab4JSf+hNMOksGPjKVRdUAr4GRcR7GvQFrbbQnpGdKhLaLFf0iIay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+OXubIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171D8C4CEC9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725245303;
	bh=mgNfDILZHBYUOaB8Di9zjgdUV7oi+Y+swUQl7vuMQOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+OXubIJyk2tm+dP2F1z/+xRbYGEK+kHzAjlMhmFSwS9iYxg9NFszul5WBLuMrLBO
	 UXQU7/yzsBwAkzBZR0JeRAkXPS3OaNr7hSeG60WQTcMkyWNS/BoHQH+JIG/WZgHW6G
	 FpUUid87NzhG1sC7FONyQckf7A1qpLavdMKxOuqlaCb7CR9a8laOhfBKbxQMuAPLwU
	 d0YRl1iSXoDS0imbfDMzcTlKaq+avu06UYEKoQJnCD/vkwCPbDZVQa7Q/2QXPN9ipd
	 0BDoh4ibZBjk4WNlxIvYqT6EqWiqaZnlt5n2jdQkDP1fz+EcPVrD89eUA5vQ1T2ced
	 e6ttLdNnEC0pA==
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71434174201so3077059b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 19:48:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/WgSk/dOgYjta7ZioBySg1evu7OjOeqngj9Li2f+lSDLH/8ydQCfR0j7yOjs8JflTH5wBa28Vq0zJW/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemRloXz00B059iHQP+uvH3Teho4dkZWtrjCpeNbc2jK1RTk20
	hOZoH7M4TbRDXKBWSdhrUNkC5p/mBzP+lVSsrmDPHPc7cq+KpP57lB+NFruA2z0SkONCIaIFtYN
	K28Ee1wGU01adFYKclzKFvnd3OGg=
X-Google-Smtp-Source: AGHT+IGUJd9Zgl9dGFrjp+bIQp0P/VXoHFKnIB1MQ7muflHc4QAbEJyU/ftjTqA53S9bjFa1LcD+nna9jSb1ekqGXFs=
X-Received: by 2002:a05:6a20:e18a:b0:1be:c6f8:c530 with SMTP id
 adf61e73a8af0-1cecf514906mr7799163637.26.1725245302669; Sun, 01 Sep 2024
 19:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819140930.122019-1-yuehaibing@huawei.com>
In-Reply-To: <20240819140930.122019-1-yuehaibing@huawei.com>
From: Zhu Lingshan <lingshan.zhu@kernel.org>
Date: Mon, 2 Sep 2024 10:48:11 +0800
X-Gmail-Original-Message-ID: <CAL=tH4bRN6PgHdrotEJRr3Op3z_5XEeBjRdqCJFUpgvS1Q_gxQ@mail.gmail.com>
Message-ID: <CAL=tH4bRN6PgHdrotEJRr3Op3z_5XEeBjRdqCJFUpgvS1Q_gxQ@mail.gmail.com>
Subject: Re: [PATCH -next] vdpa: Remove unused declarations
To: Yue Haibing <yuehaibing@huawei.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shannon.nelson@amd.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Reviewed-by: Zhu Lingshan <lingshan.zhu@kernel.org>

Yue Haibing <yuehaibing@huawei.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=80 22:12=E5=86=99=E9=81=93=EF=BC=9A

>
> There is no caller and implementation in tree.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.h | 3 ---
>  drivers/vdpa/pds/cmds.h         | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_b=
ase.h
> index 0f347717021a..aa36de361c10 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -112,15 +112,12 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u6=
4 offset,
>                             const void *src, int length);
>  u8 ifcvf_get_status(struct ifcvf_hw *hw);
>  void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
> -void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
>  void ifcvf_reset(struct ifcvf_hw *hw);
>  u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
>  u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
>  int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
>  u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
>  int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
> -struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
> -int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
>  u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
>  u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
> diff --git a/drivers/vdpa/pds/cmds.h b/drivers/vdpa/pds/cmds.h
> index e24d85cb8f1c..6b1bc33356b0 100644
> --- a/drivers/vdpa/pds/cmds.h
> +++ b/drivers/vdpa/pds/cmds.h
> @@ -14,5 +14,4 @@ int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, =
u16 qid, u16 invert_idx,
>                          struct pds_vdpa_vq_info *vq_info);
>  int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 inv=
ert_idx,
>                           struct pds_vdpa_vq_info *vq_info);
> -int pds_vdpa_cmd_set_features(struct pds_vdpa_device *pdsv, u64 features=
);
>  #endif /* _VDPA_CMDS_H_ */
> --
> 2.34.1
>

