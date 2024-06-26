Return-Path: <linux-kernel+bounces-230597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E856917F01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844F41F266EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43017C7AD;
	Wed, 26 Jun 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7A8be82"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955F178CEA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399348; cv=none; b=aEb/N8+P4/cKEYCVpuC4b4NXURISM85pVVR1NQm3qu+0WHbijdDkjkF2Kw8zBkW4KxYlHbiPc603m+wVg2Ngp6Xa0Bk//nOGpHT54FH3uQ66dDWViwmHmIMfl1UsvXjBGiuUtA8mvArhaMetHUyJSYU0sHa69Z+FIqcvzz1MV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399348; c=relaxed/simple;
	bh=CldZG81f2P1GudsYImj66g1IJo1zRAPfNNf2CvoUdRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy/YCF+8oZZSXw5p5hJ2fLKsqzF1GvJrGt4VGOnO68sTccySdvsIfqj+EGrO+A67xYxjvH3xOEqGxljK8g+yO6T15dywrqFzVZq33Ybrjioo5p5Wmjd9c3rB74RNYbqgQzpRWjVk3utpT5isdOBNJdPsoJxO0vRaKFXV4VhjWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7A8be82; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso108393a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719399342; x=1720004142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvpHCyqwIEWrIEkuFm3ZwyDR/Vs8dxE4a8djGzFogD8=;
        b=Z7A8be82QUk2+P7I6Y4aGtrWVym3RY9ydjc3yMHqO+EvAjMsEdnBxrTNAyxOz0uxGA
         wljqjnth+nSpElnhwUYYGx+gAFp6UaqUC70l2YVtnAr59sOTR4cvK7xeCjHjZPNv4of4
         L5sqODnhcJIN4qj5XRT6N6qe3iGfaF9oyAQ71YiYoS3bXUx9YO/E5bP7qmUjoqK0R7eH
         VoLayrWSXiPeJQ8WNAroBBHKvbkg2IOV9EMXS7Wf5ZZl0T+BV2ea4p+o0vGGmQuTAROh
         7I/HvYinMsMRnDFILLZ1Giisq/aPw7zEKwWA4iZBhWI0p+rCoV1pqSP9nvPIoXpIDs7X
         x0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399342; x=1720004142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvpHCyqwIEWrIEkuFm3ZwyDR/Vs8dxE4a8djGzFogD8=;
        b=IFZd1DDr8AbkvoIKZ0N0FqFuhN/d9Oi8W7x/U5Ss4DUDg7TrbjDsLKdIt1FCyatDfX
         IgsP6wmYWcmSv+tRY4zhw69HuiM9PcnPJOuZp5EXdq+/4MW0Fx704HlpzDAKrHM+TsFy
         8WyczpWGC1XoG3fWwqSlhEItubJ7TWLBaLN0WdWViKpwXlzflMe8gvIe8gjBq0BpS/6i
         3N5AXtRAyAwabhUG1vItcBwfI1+Z6ghFnA4Lw6xHL1NeMP9F0ykQacZMUqOSYWxx0DK5
         Sx7QebYNxyjPwCBX2bHOY6P5NPPNmxF/y38U4lGfXa//XTgjrJkuj2q/BZA5B0hohYMk
         LJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCURZ9gwLKbL0d+xa9ict7bBK7mQ7vdeFb9fPnYF0LlOmQS+0u3U7GB4JAmDHu214hYgAidmBluLGL3sOMhQ8WmnF9qe2JTUSVht0Dx6
X-Gm-Message-State: AOJu0Yzifwa2DLo8FEYCX4K5zUneLdw14XqzQaVbcp0t8xkXqvSB9KCn
	btnp5t5wl7vsFDHEiHC/o2S7CbzXDTTbBp00rPBQ8idEHaWz3ev+laJen5+VIiN6bEtcPXCgFBK
	Ka+vEaxHqh2iI/nZYJ9O4mW7zPUNfkb2fTyBcMQ==
X-Google-Smtp-Source: AGHT+IFLL8v+ApRsdF1oQyJ4gYj95DTo+ZpYfz8vWOavfb/Rr+f7PYpka089Pmz5x/tFDV2Ns1y5LdQGTy6tzXBS1V0=
X-Received: by 2002:a50:8d4f:0:b0:57d:10bb:b42b with SMTP id
 4fb4d7f45d1cf-57d4bdcba20mr6272487a12.26.1719399342459; Wed, 26 Jun 2024
 03:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <de8ab492-272c-4bed-92eb-a0c3303543b2@quicinc.com> <CA+6=WdSDSvcMJsmUNW6NXqNXktYjp0xdqk8Y+FakiPBYcXfgGw@mail.gmail.com>
 <a5734572-c822-493a-a15a-63dcf37d60cc@quicinc.com>
In-Reply-To: <a5734572-c822-493a-a15a-63dcf37d60cc@quicinc.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Wed, 26 Jun 2024 18:55:31 +0800
Message-ID: <CA+6=WdSYZCOQvOLCVV9BVBs_=UKbw9Sn8t7a58hY=Y--7JqGvg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] drm/panel: jd9365da: Modify the method of sending commands
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	jagan@edgeble.ai, neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Shuijing Li <shuijing.li@mediatek.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:49=E2=80=AFAM Jessica Zhang <quic_jesszhan@quicin=
c.com> wrote:
>
>
>
> On 6/25/2024 5:13 AM, zhaoxiong lv wrote:
> > On Tue, Jun 25, 2024 at 7:41=E2=80=AFAM Jessica Zhang <quic_jesszhan@qu=
icinc.com> wrote:
> >>
> >>
> >>
> >> On 6/24/2024 7:19 AM, Zhaoxiong Lv wrote:
> >>> Currently, the init_code of the jd9365da driver is placed
> >>> in the enable() function and sent, but this seems to take
> >>> a long time. It takes 17ms to send each instruction (an init
> >>> code consists of about 200 instructions), so it takes
> >>> about 3.5s to send the init_code. So we moved the sending
> >>> of the inti_code to the prepare() function, and each
> >>> instruction seemed to take only 25=CE=BCs.
> >>>
> >>> We checked the DSI host and found that the difference in
> >>> command sending time is caused by the different modes of
> >>> the DSI host in prepare() and enable() functions.
> >>> Our DSI Host only supports sending cmd in LP mode, The
> >>> prepare() function can directly send init_code (LP->cmd)
> >>> in LP mode, but the enable() function is in HS mode and
> >>> needs to switch to LP mode before sending init code
> >>> (HS->LP->cmd->HS). Therefore, it takes longer to send
> >>> the command.
> >>>
> >>> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.c=
om>
> >>
> >> Hi Zhaoxiong,
> >>
> >> Just curious, if the host expects that commands are sent in LP mode, w=
hy
> >> isn't the MIPI_DSI_MODE_LPM flag set before sending the DCS commands?
> >>
> >> Thanks,
> >>
> >> Jessica Zhang
> >
> > hi jessica
> >
> > We have tried to set dsi->mode_flags to MIPI_DSI_MODE_LPM in the
> > probe() function,
> > but this seems to still happen. MTK colleagues believe that the host
> > dsi configuration is
> > still in LP mode during the prepare() function, and when in the
> > enable() function, the host
> > dsi is already in HS mode. However, since the command must be sent in
> > LP mode, it will
> > switch back and forth between HS->LP->HS.
> >
> > Add Mediatek colleagues=EF=BC=88shuijing.li@mediatek.corp-partner.googl=
e.com=EF=BC=89
>
> Got it. Even drivers that call their init commands in prepare() set the
> LPM flag [1][2] when applicable so I was just wondering why this driver
> doesn't seem to set LPM at all even though it is going into LP mode.
>
> [1]
> https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/panel/p=
anel-visionox-vtdr6130.c#L46
>
> [2]
> https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/panel/p=
anel-visionox-r66451.c#L46

hi  jessica

The initial default setting of our host DSI is the LP mode.





>
> >
> >
> >>
> >>> ---
> >>> Changes between V5 and V4:
> >>> - 1. No changes.
> >>>
> >>> V4:https://lore.kernel.org/all/20240620080509.18504-2-lvzhaoxiong@hua=
qin.corp-partner.google.com/
> >>>
> >>> Changes between V4 and V3:
> >>> - 1. Only move mipi_dsi_dcs_write_buffer from enable() function to pr=
epare() function,
> >>> -    and no longer use mipi_dsi_dcs_write_seq_multi.
> >>>
> >>> V3:https://lore.kernel.org/all/20240614145510.22965-2-lvzhaoxiong@hua=
qin.corp-partner.google.com/
> >>>
> >>> ---
> >>>    .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 24 +++++++++------=
----
> >>>    1 file changed, 11 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drive=
rs/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> index 4879835fe101..a9c483a7b3fa 100644
> >>> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> @@ -52,21 +52,9 @@ static int jadard_enable(struct drm_panel *panel)
> >>>    {
> >>>        struct device *dev =3D panel->dev;
> >>>        struct jadard *jadard =3D panel_to_jadard(panel);
> >>> -     const struct jadard_panel_desc *desc =3D jadard->desc;
> >>>        struct mipi_dsi_device *dsi =3D jadard->dsi;
> >>> -     unsigned int i;
> >>>        int err;
> >>>
> >>> -     msleep(10);
> >>> -
> >>> -     for (i =3D 0; i < desc->num_init_cmds; i++) {
> >>> -             const struct jadard_init_cmd *cmd =3D &desc->init_cmds[=
i];
> >>> -
> >>> -             err =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD936=
5DA_INIT_CMD_LEN);
> >>> -             if (err < 0)
> >>> -                     return err;
> >>> -     }
> >>> -
> >>>        msleep(120);
> >>>
> >>>        err =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> >>> @@ -100,6 +88,8 @@ static int jadard_disable(struct drm_panel *panel)
> >>>    static int jadard_prepare(struct drm_panel *panel)
> >>>    {
> >>>        struct jadard *jadard =3D panel_to_jadard(panel);
> >>> +     const struct jadard_panel_desc *desc =3D jadard->desc;
> >>> +     unsigned int i;
> >>>        int ret;
> >>>
> >>>        ret =3D regulator_enable(jadard->vccio);
> >>> @@ -117,7 +107,15 @@ static int jadard_prepare(struct drm_panel *pane=
l)
> >>>        msleep(10);
> >>>
> >>>        gpiod_set_value(jadard->reset, 1);
> >>> -     msleep(120);
> >>> +     msleep(130);
> >>> +
> >>> +     for (i =3D 0; i < desc->num_init_cmds; i++) {
> >>> +             const struct jadard_init_cmd *cmd =3D &desc->init_cmds[=
i];
> >>> +
> >>> +             ret =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD936=
5DA_INIT_CMD_LEN);
> >>> +             if (ret < 0)
> >>> +                     return ret;
> >>> +     }
> >>>
> >>>        return 0;
> >>>    }
> >>> --
> >>> 2.17.1
> >>>

