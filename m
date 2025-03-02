Return-Path: <linux-kernel+bounces-540465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B09A4B0F9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3462B1891913
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDD1DC9B5;
	Sun,  2 Mar 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EClvfmWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B7A944;
	Sun,  2 Mar 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740911835; cv=none; b=gg6aJPk8uD+ZLPjQQ88GSpi46iHMaVBOz2IBItgEC/SJ7tzHhyFDyUwwVbBUxpUK4NE/nsSd+CAG0viBv/AopvQqK1VBnTCkDrqmSq79Kgw05TFgDjdxayEL/Fd4pSaDffQDTlou9PO0zsYUBRcMy644Vd/rLT61+YAIsMsE34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740911835; c=relaxed/simple;
	bh=JlohdMVnyQ/+Ez/P/y22XElWn/u+LvWChNZCG+JtZUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfhFfUnstUleENURQ1HMXkoUvJGLN8PCDXafnecV62PexjQ4V+2WmjH1TtWOFbOjzfv8+XmZM4qpwwMGX/6VOVPh5XXHsrunkn+cqoh2/6novG/u1gPfS3q1B7AUqq+1GFaIEskpudSD/pCn5JTGXNdj1bGpWqSbzzDzkWWfsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EClvfmWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB22DC4CEEC;
	Sun,  2 Mar 2025 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740911834;
	bh=JlohdMVnyQ/+Ez/P/y22XElWn/u+LvWChNZCG+JtZUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EClvfmWKafT5nW+SWifcEbL0MfoDA95Lu4aOjXK/7tec7ebyRZKhU900AV2FJxUaz
	 qkzTkMAwv5DeNvDxINI0GeC0LHiExjW+xIUhkHnpi/YOaFQNvcvqkkeCcYl0jLENrp
	 xLC7CZllD/MbKry2/7dIT3Dm2k3NQMbRShoZX+SpsgSgEHvdwVRw2Z+f+DJlsRPyCa
	 3edWA94CMETO43Cv/fmt0AmLNHBOwZSwTNg7bgjFY6OiHSnZUd68SQRCE7EC1QbeD9
	 h/NJUC14UeXqv5FAVifMQ7pqdn6PDGnI5lKazekkdhsCvRkAHXHVHEJCIw2Svk1Xw0
	 wesupiymER7vQ==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso5836192a91.1;
        Sun, 02 Mar 2025 02:37:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoNIbjhT9EdQHwzUfI/T5kc+W+XBFSMeAU27AiJ21qJ8Qkwfv/5ZIQ08QfC8xmgWfc/mRSRBnUIMIJ@vger.kernel.org, AJvYcCWBxnN641h1I0/IN2V3KCmbYqA9Bg1tslHPKcUDjPkhV0SJ5hSyDQ6kN4uIrRLBnEYLD2cMgUNCfZa48uw2@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnaFIz8+iy+aijdOD+MafTAA5tBsUowhn+eNYhdJ2qt4SoPFY
	XijP1s5c1sralov0gi48UBucDxNLglHdBJOPHT7Nq3SdGZceLpAnBJeEhZaieky1DVGMu8v1uom
	5hLySwOZLiKjG/NAX2vDGq2YkXQ==
X-Google-Smtp-Source: AGHT+IECuNO+cLo9RaRwNYsz+RqAixzhNovU5aV5xtQa1KFE9PEc8PNBOvT8hp8OYymIgmgIZdenWZ4vWRbBtbMZOQs=
X-Received: by 2002:a17:90b:3511:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2febabd9c82mr14184256a91.28.1740911834367; Sun, 02 Mar 2025
 02:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-3-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 18:38:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-dk8qtn_uHifQs3Gcgkh=1LZ1K6YNK+37tuDzNgNyn6A@mail.gmail.com>
X-Gm-Features: AQ5f1Jp32-133VEcwKRU6i5w8wjyNjENu9U_sKf5xUa7Fef2g7VV85UQ150m7NI
Message-ID: <CAAOTY_-dk8qtn_uHifQs3Gcgkh=1LZ1K6YNK+37tuDzNgNyn6A@mail.gmail.com>
Subject: Re: [PATCH v7 02/43] drm/mediatek: mtk_dpi: Add support for Pattern
 Generator in debugfs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This IP includes a Pattern Generator which is useful for debugging
> and testing purposes: add the relevant register and bits to the
> mtk_dpi_regs.h header, and implement support for it in mtk_dpi.
>
> Adding this required to introduce a .debugfs_init() callback for
> the DPI bridge, which creates a "dpi_test_pattern" file in the
> directory of the appropriate connector.
>
> The pattern generator can generate various internal patterns and
> this submission includes support for:
>  - 256 or 1024 shades of gray in a Vertical or Horizontal Pattern
>  - Vertical Color Bars
>  - Frame border
>  - Dot Moire
>
> This generator also supports filling the entire screen with one
> custom color, but support for that is not included in this commit.
>
> Enabling and disabling this generator can be done by sending a
> string to the dpi_test_pattern debugfs file; the pattern is
> expected to be formatted as follows:
>
>          <enable (1) or disable (0)> <pattern number>
>
> where the pattern number can be a number from 0 to 7, excluding 5.
>
> Of course 5 is excluded because that activates custom color fill
> which, again, is not supported in this commit.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 108 ++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h |   4 +
>  2 files changed, 112 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 1864eb02dbf5..fc937490feda 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -4,8 +4,10 @@
>   * Author: Jie Qiu <jie.qiu@mediatek.com>
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/component.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/media-bus-format.h>
> @@ -166,6 +168,18 @@ static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 of=
fset, u32 val, u32 mask)
>         writel(tmp, dpi->regs + offset);
>  }
>
> +static void mtk_dpi_test_pattern_en(struct mtk_dpi *dpi, u8 type, bool e=
nable)
> +{
> +       u32 val;
> +
> +       if (enable)
> +               val =3D FIELD_PREP(DPI_PAT_SEL, type) | DPI_PAT_EN;
> +       else
> +               val =3D 0;
> +
> +       mtk_dpi_mask(dpi, DPI_PATTERN0, val, DPI_PAT_SEL | DPI_PAT_EN);
> +}
> +
>  static void mtk_dpi_sw_reset(struct mtk_dpi *dpi, bool reset)
>  {
>         mtk_dpi_mask(dpi, DPI_RET, reset ? RST : 0, RST);
> @@ -767,6 +781,99 @@ mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
>         return MODE_OK;
>  }
>
> +static int mtk_dpi_debug_tp_show(struct seq_file *m, void *arg)
> +{
> +       struct mtk_dpi *dpi =3D m->private;
> +       bool en;
> +       u32 val;
> +
> +       if (!dpi)
> +               return -EINVAL;
> +
> +       val =3D readl(dpi->regs + DPI_PATTERN0);
> +       en =3D val & DPI_PAT_EN;
> +       val =3D FIELD_GET(DPI_PAT_SEL, val);
> +
> +       seq_printf(m, "DPI Test Pattern: %s\n", en ? "Enabled" : "Disable=
d");
> +
> +       if (en) {
> +               seq_printf(m, "Internal pattern %d: ", val);
> +               switch (val) {
> +               case 0:
> +                       seq_puts(m, "256 Vertical Gray\n");
> +                       break;
> +               case 1:
> +                       seq_puts(m, "1024 Vertical Gray\n");
> +                       break;
> +               case 2:
> +                       seq_puts(m, "256 Horizontal Gray\n");
> +                       break;
> +               case 3:
> +                       seq_puts(m, "1024 Horizontal Gray\n");
> +                       break;
> +               case 4:
> +                       seq_puts(m, "Vertical Color bars\n");
> +                       break;
> +               case 6:
> +                       seq_puts(m, "Frame border\n");
> +                       break;
> +               case 7:
> +                       seq_puts(m, "Dot moire\n");
> +                       break;
> +               default:
> +                       seq_puts(m, "Invalid selection\n");
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static ssize_t mtk_dpi_debug_tp_write(struct file *file, const char __us=
er *ubuf,
> +                                     size_t len, loff_t *offp)
> +{
> +       struct seq_file *m =3D file->private_data;
> +       u32 en, type;
> +       char buf[6];
> +
> +       if (!m || !m->private || *offp || len > sizeof(buf) - 1)
> +               return -EINVAL;
> +
> +       memset(buf, 0, sizeof(buf));
> +       if (copy_from_user(buf, ubuf, len))
> +               return -EFAULT;
> +
> +       if (sscanf(buf, "%u %u", &en, &type) !=3D 2)
> +               return -EINVAL;
> +
> +       if (en < 0 || en > 1 || type < 0 || type > 7)
> +               return -EINVAL;
> +
> +       mtk_dpi_test_pattern_en((struct mtk_dpi *)m->private, type, en);
> +       return len;
> +}
> +
> +static int mtk_dpi_debug_tp_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, mtk_dpi_debug_tp_show, inode->i_private)=
;
> +}
> +
> +static const struct file_operations mtk_dpi_debug_tp_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D mtk_dpi_debug_tp_open,
> +       .read =3D seq_read,
> +       .write =3D mtk_dpi_debug_tp_write,
> +       .llseek =3D seq_lseek,
> +       .release =3D single_release,
> +};
> +
> +static void mtk_dpi_debugfs_init(struct drm_bridge *bridge, struct dentr=
y *root)
> +{
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       debugfs_create_file("dpi_test_pattern", 0640, root, dpi, &mtk_dpi=
_debug_tp_fops);
> +}
> +
>  static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
>         .attach =3D mtk_dpi_bridge_attach,
>         .mode_set =3D mtk_dpi_bridge_mode_set,
> @@ -779,6 +886,7 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_f=
uncs =3D {
>         .atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_st=
ate,
>         .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>         .atomic_reset =3D drm_atomic_helper_bridge_reset,
> +       .debugfs_init =3D mtk_dpi_debugfs_init,
>  };
>
>  void mtk_dpi_start(struct device *dev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/me=
diatek/mtk_dpi_regs.h
> index 62bd4931b344..a0b1d18bbbf7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -235,4 +235,8 @@
>  #define MATRIX_SEL_RGB_TO_JPEG         0
>  #define MATRIX_SEL_RGB_TO_BT601                2
>
> +#define DPI_PATTERN0           0xf00
> +#define DPI_PAT_EN                     BIT(0)
> +#define DPI_PAT_SEL                    GENMASK(6, 4)
> +
>  #endif /* __MTK_DPI_REGS_H */
> --
> 2.48.1
>

