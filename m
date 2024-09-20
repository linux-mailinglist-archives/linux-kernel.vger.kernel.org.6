Return-Path: <linux-kernel+bounces-334028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57497D18E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A441C224FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B544384;
	Fri, 20 Sep 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkBynPzc"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633046434
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816392; cv=none; b=L2yTDWZMMEJ/9K/xM7H4clguw2+xWiXeJzi9nRpe4gx0XtbQ7O14VQ2Skq1QgVNmJhgEtSoY0WCzfGyijIUqWBCILnrrcG13ZzecW7xaiHiJ/6BqTVx5WYrU6cvZG/kn0yYQtPzc7i+sGXiNc6qyl7O9iHQ7jJrXVI/dO7BxOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816392; c=relaxed/simple;
	bh=w3xBviy+C9qc1c1tS216kp0KAKGu2oN9lQuFTgG5sbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1oTkUCRkBUGZX5nhrigyTOQc0mYnwauXBhz8inKu3kO3BjiRwBJ2sa6hKdFCvsW3fkwHZ2wXZFaVW4X4C6wtd+BQkpByBqztG0uFTIVlYeT8NyknUSr97MiOJ5Wwa8rJHAlM2m1cU5RCQyJ2FULXToAszjFhjLlsDDSx1tYwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QkBynPzc; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27d045a73easo1037144fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726816390; x=1727421190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caH7cFT7+7ySkxzllVIsbIUHY5K2G70vMbFwZUNwr50=;
        b=QkBynPzcgSknorqsD3iJgzJL7+MLxaMszg9gAWG+yp3S7Bsq22vMEM/Ia+H0vaK/tj
         hy9AYabAmolCvel6SlWpFn3A+8nuHgTt8aJ1K7eE+fEioiSfe4esaxeEA4pGb3Aj5Y6J
         D0pxPXzGKAf0BzhyHO+UZHZFovBxvejWj54Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726816390; x=1727421190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caH7cFT7+7ySkxzllVIsbIUHY5K2G70vMbFwZUNwr50=;
        b=XCtLmEr4Zs/lFUFnBAx6J1JEFNSJOHVIuyxYRhesZWjuMfVZTRWowNpDXlQpe0yqKa
         mvSsQzoZQ9TwvoMafwbaht/aN+agWaMkUle9yqwOplPkLTRzeX9XLymZxEWnLXO9Rh3+
         x7MIpauyCCgVTK2cnwhkVFNuYW0avG++9Ir+Q4Lkg2k+p05EjvUCAxjUPNQIEenURw6h
         whrzwuaqt5RZy6P36NbRZUXEcjnsm4/679Br3j4oXWloSr+/7Gi6A/44ci93v2BUQ7jJ
         Bm+i5WybofI/hHHOHf5/EQuw+wZheYiL/j2QKVY+1cw9g1Bj2rjDXmzicZlc4QD+QxpN
         GRKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLR++e/ifpSBpycmmu5DpUV7ZbwTtZOA8Dn/lZXjFheIrAeaj7TGoNQrLOaj/wre5iVCUWibvqFWumJUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnEFSey9jSs+PJcJoiqTLCEDGoUn3y5x3eCLvrX/8DF/zdks+
	s6tWpVBsKg8NlBhquNbvtzUYai0jA8OQsIM2MfwsSrIHmBzE+LYmzdlANHpvqFTSafdkmxzR3YI
	m5ZvG919udQ15Cm6pGhSp6a9JaB2KGmLIVx3Yw2nEJ3NWZ/JGhA==
X-Google-Smtp-Source: AGHT+IF7pmxmQ2zZKLssyNA+tPbBX5nENHTmyYH5pFM3UOlSzIni226Q6pCicULMddjglqg40yk2jhUxVbW1i1nQD/o=
X-Received: by 2002:a05:6870:3321:b0:277:d7f1:db53 with SMTP id
 586e51a60fabf-2803cf48632mr914748fac.17.1726816389666; Fri, 20 Sep 2024
 00:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091916.1484-1-Hermes.Wu@ite.com.tw> <20240919091916.1484-2-Hermes.Wu@ite.com.tw>
In-Reply-To: <20240919091916.1484-2-Hermes.Wu@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 20 Sep 2024 15:12:58 +0800
Message-ID: <CAEXTbpevwjHL7=hvVpw5KS5M2q8GP067s0AxWsy8T4Wf=J4Lew@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/bridge: it6505: HDCP CTS fail on repeater items
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>, Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	allen chen <allen.chen@ite.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hermes,
On Thu, Sep 19, 2024 at 5:20=E2=80=AFPM Hermes Wu <Hermes.Wu@ite.com.tw> wr=
ote:
>
> From: allen chen <allen.chen@ite.corp-partner.google.com>
>
> Fix HDCP CTS items on UNIGRAF DPR-100.
>
> Change-Id: I03f0758779f73164c8ae2fdf61e41dc693e27605
>
> Change-Id: Ib7a8fabaeccd56d3bd7c8adc7384a363b0f7b88d
Remove the Change-Id's as mentioned in the other patch.
> Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
You'll want to add a Co-developed-by tag if you make modifications on
this patch.
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 152 ++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 7a4608844de3..cef02c8c363e 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -298,11 +298,11 @@
>  #define MAX_LANE_COUNT 4
>  #define MAX_LINK_RATE HBR
>  #define AUTO_TRAIN_RETRY 3
> -#define MAX_HDCP_DOWN_STREAM_COUNT 10
> +#define MAX_HDCP_DOWN_STREAM_COUNT 127
>  #define MAX_CR_LEVEL 0x03
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
> -#define AUX_FIFO_MAX_SIZE 32
> +#define AUX_FIFO_MAX_SIZE 16
>  #define PIXEL_CLK_DELAY 1
>  #define PIXEL_CLK_INVERSE 0
>  #define ADJUST_PHASE_THRESHOLD 80000
> @@ -326,6 +326,9 @@ enum aux_cmd_type {
>         CMD_AUX_NATIVE_READ =3D 0x0,
>         CMD_AUX_NATIVE_WRITE =3D 0x5,
>         CMD_AUX_I2C_EDID_READ =3D 0xB,
> +
> +       /*extend read ncommand */
> +       CMD_AUX_GET_KSV_LIST =3D 0x10,
>  };
>
>  enum aux_cmd_reply {
> @@ -973,7 +976,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it=
6505,
>         it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MOD=
E);
>
>  aux_op_start:
> -       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ) {
> +       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ || cmd =3D=3D CMD_AUX_GET_KS=
V_LIST) {
>                 /* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE byte=
s. */
>                 size =3D min_t(size_t, size, AUX_FIFO_MAX_SIZE);
>                 /* Enable AUX FIFO read back and clear FIFO */
> @@ -1004,7 +1007,7 @@ static ssize_t it6505_aux_operation(struct it6505 *=
it6505,
>                                   size);
>
>         /* Aux Fire */
> -       it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +       it6505_write(it6505, REG_AUX_CMD_REQ, (cmd & 0x0F));
>
>         ret =3D it6505_aux_wait(it6505);
>         if (ret < 0)
> @@ -1038,7 +1041,7 @@ static ssize_t it6505_aux_operation(struct it6505 *=
it6505,
>                 goto aux_op_start;
>         }
>
> -       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ) {
> +       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ || cmd =3D=3D CMD_AUX_GET_KS=
V_LIST) {
>                 for (i =3D 0; i < size; i++) {
>                         ret =3D it6505_read(it6505, REG_AUX_DATA_FIFO);
>                         if (ret < 0)
> @@ -1063,7 +1066,7 @@ static ssize_t it6505_aux_operation(struct it6505 *=
it6505,
>         ret =3D i;
>
>  aux_op_err:
> -       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ) {
> +       if (cmd =3D=3D CMD_AUX_I2C_EDID_READ || cmd =3D=3D CMD_AUX_GET_KS=
V_LIST) {
>                 /* clear AUX FIFO */
>                 it6505_set_bits(it6505, REG_AUX_CTRL,
>                                 AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> @@ -1084,18 +1087,25 @@ static ssize_t it6505_aux_do_transfer(struct it65=
05 *it6505,
>                                       size_t size, enum aux_cmd_reply *re=
ply)
>  {
>         int i, ret_size, ret =3D 0, request_size;
> +       struct device *dev =3D &it6505->client->dev;
This is unused and removed in the following patch. Please remove this.
>
>         mutex_lock(&it6505->aux_lock);
> -       for (i =3D 0; i < size; i +=3D 4) {
> -               request_size =3D min((int)size - i, 4);
> +       for (i =3D 0; i < size; ) {
> +               if (cmd =3D=3D CMD_AUX_I2C_EDID_READ || cmd =3D=3D CMD_AU=
X_GET_KSV_LIST)
> +                       request_size =3D min((int)size - i, AUX_FIFO_MAX_=
SIZE);
> +               else
> +                       request_size =3D min((int)size - i, 4);
> +
>                 ret_size =3D it6505_aux_operation(it6505, cmd, address + =
i,
>                                                 buffer + i, request_size,
>                                                 reply);
> +
Remove the blank line here.
>                 if (ret_size < 0) {
>                         ret =3D ret_size;
>                         goto aux_op_err;
>                 }
>
> +               i +=3D request_size;
>                 ret +=3D ret_size;
>         }
>
> @@ -1186,6 +1196,35 @@ static int it6505_get_edid_block(void *data, u8 *b=
uf, unsigned int block,
>         return 0;
>  }
>
> +static int it6505_get_ksvlist(struct it6505 *it6505, u8 *buf, size_t len=
)
> +{
> +       int i, request_size, ret;
> +       struct device *dev =3D &it6505->client->dev;
> +       enum aux_cmd_reply reply;
> +
> +       for (i =3D 0; i < len; ) {
> +               request_size =3D min((int)len - i, 15);
> +
> +               ret =3D it6505_aux_do_transfer(it6505, CMD_AUX_GET_KSV_LI=
ST,
> +                                            DP_AUX_HDCP_KSV_FIFO,
> +                                            buf + i, request_size, &repl=
y);
> +
> +               DRM_DEV_DEBUG_DRIVER(dev, "request_size =3D %d, ret =3D%d=
", request_size, ret);
> +               if (ret < 0)
> +                       return ret;
> +
> +               i +=3D request_size;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "ksv read cnt =3D %d down_stream_cnt=3D=
%d ", i, i/5);
> +
> +       for (i =3D 0 ; i < len; i +=3D 5)
> +               DRM_DEV_DEBUG_DRIVER(dev, "ksv[%d] =3D %02X%02X%02X%02X%0=
2X",
> +                               i/5, buf[i], buf[i + 1], buf[i + 2], buf[=
i + 3], buf[i + 4]);
> +
> +       return len;
> +}
> +
>  static void it6505_variable_config(struct it6505 *it6505)
>  {
>         it6505->link_rate_bw_code =3D HBR;
> @@ -1927,6 +1966,7 @@ static void it6505_hdcp_part1_auth(struct it6505 *i=
t6505)
>         it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_START,
>                         HDCP_TRIGGER_START);
>
> +       it6505->is_repeater =3D (hdcp_bcaps & DP_BCAPS_REPEATER_PRESENT);
>         it6505->hdcp_status =3D HDCP_AUTH_GOING;
>  }
>
> @@ -1963,7 +2003,7 @@ static int it6505_setup_sha1_input(struct it6505 *i=
t6505, u8 *sha1_input)
>  {
>         struct device *dev =3D &it6505->client->dev;
>         u8 binfo[2];
> -       int down_stream_count, i, err, msg_count =3D 0;
> +       int down_stream_count, err, msg_count =3D 0;
>
>         err =3D it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
>                               ARRAY_SIZE(binfo));
> @@ -1989,17 +2029,12 @@ static int it6505_setup_sha1_input(struct it6505 =
*it6505, u8 *sha1_input)
>                 return 0;
>         }
>
> -       for (i =3D 0; i < down_stream_count; i++) {
> -               err =3D it6505_get_dpcd(it6505, DP_AUX_HDCP_KSV_FIFO +
> -                                     (i % 3) * DRM_HDCP_KSV_LEN,
> -                                     sha1_input + msg_count,
> -                                     DRM_HDCP_KSV_LEN);
>
> -               if (err < 0)
> -                       return err;
> +       err =3D  it6505_get_ksvlist(it6505, sha1_input, down_stream_count=
 * 5);
> +       if (err < 0)
> +               return err;
>
> -               msg_count +=3D 5;
> -       }
> +       msg_count +=3D down_stream_count * 5;
>
>         it6505->hdcp_down_stream_count =3D down_stream_count;
>         sha1_input[msg_count++] =3D binfo[0];
> @@ -2027,7 +2062,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct =
it6505 *it6505)
>  {
>         struct device *dev =3D &it6505->client->dev;
>         u8 av[5][4], bv[5][4];
> -       int i, err;
> +       int i, err, retry;
>
>         i =3D it6505_setup_sha1_input(it6505, it6505->sha1_input);
>         if (i <=3D 0) {
> @@ -2037,21 +2072,28 @@ static bool it6505_hdcp_part2_ksvlist_check(struc=
t it6505 *it6505)
>
>         it6505_sha1_digest(it6505, it6505->sha1_input, i, (u8 *)av);
>
> -       err =3D it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
> -                             sizeof(bv));
> +       for (retry =3D 0; retry < 3; retry++) {
>
Remove this blank line.
> -       if (err < 0) {
> -               dev_err(dev, "Read V' value Fail");
> -               return false;
> -       }
> +               err =3D it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (=
u8 *)bv,
> +                                       sizeof(bv));
>
And also this blank line.
> -       for (i =3D 0; i < 5; i++)
> -               if (bv[i][3] !=3D av[i][0] || bv[i][2] !=3D av[i][1] ||
> -                   bv[i][1] !=3D av[i][2] || bv[i][0] !=3D av[i][3])
> -                       return false;
> +               if (err < 0) {
> +                       dev_err(dev, "Read V' value Fail %d", retry);
> +                       continue;
> +               }
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "V' all match!!");
> -       return true;
> +               for (i =3D 0; i < 5; i++) {
> +                       if (bv[i][3] !=3D av[i][0] || bv[i][2] !=3D av[i]=
[1] ||
> +                               bv[i][1] !=3D av[i][2] || bv[i][0] !=3D a=
v[i][3])
> +                               break;
> +
> +                       DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d"=
, retry, i);
> +                       return true;
> +               }
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "V' NOT match!! %d", retry);
> +       return false;
>  }
>
>  static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
> @@ -2059,7 +2101,7 @@ static void it6505_hdcp_wait_ksv_list(struct work_s=
truct *work)
>         struct it6505 *it6505 =3D container_of(work, struct it6505,
>                                              hdcp_wait_ksv_list);
>         struct device *dev =3D &it6505->client->dev;
> -       unsigned int timeout =3D 5000;
> +       unsigned int timeout =3D 2000;
>         u8 bstatus =3D 0;
>         bool ksv_list_check;
>
> @@ -2079,21 +2121,18 @@ static void it6505_hdcp_wait_ksv_list(struct work=
_struct *work)
>
>         if (timeout =3D=3D 0) {
>                 DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait fail=
ed");
> -               goto timeout;
> +               goto hdcp_ksvlist_fail;
>         }
>
>         ksv_list_check =3D it6505_hdcp_part2_ksvlist_check(it6505);
>         DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
> -                            ksv_list_check ? "pass" : "fail");
> -       if (ksv_list_check) {
> -               it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> -                               HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_D=
ONE);
> +                               ksv_list_check ? "pass" : "fail");
> +
> +       if (ksv_list_check)
>                 return;
> -       }
> -timeout:
> -       it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> -                       HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
> -                       HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
> +
> +hdcp_ksvlist_fail:
> +       it6505_start_hdcp(it6505);
>  }
>
>  static void it6505_hdcp_work(struct work_struct *work)
> @@ -2139,7 +2178,7 @@ static void it6505_hdcp_work(struct work_struct *wo=
rk)
>         it6505_hdcp_part1_auth(it6505);
>  }
>
> -static void it6505_show_hdcp_info(struct it6505 *it6505)
> +static void it6505_show_hdcp_info(struct it6505 *it6505, bool repeater_i=
nfo)
>  {
>         struct device *dev =3D &it6505->client->dev;
>         int i;
> @@ -2150,7 +2189,7 @@ static void it6505_show_hdcp_info(struct it6505 *it=
6505)
>         DRM_DEV_DEBUG_DRIVER(dev, "bksv =3D 0x%*ph",
>                              (int)ARRAY_SIZE(it6505->bksvs), it6505->bksv=
s);
>
> -       if (it6505->is_repeater) {
> +       if ((repeater_info) && (it6505->is_repeater)) {
I don't think we need the extra brackets for repeater_info and
it6505->is_repeater here.
>                 DRM_DEV_DEBUG_DRIVER(dev, "hdcp_down_stream_count: %d",
>                                      it6505->hdcp_down_stream_count);
>                 DRM_DEV_DEBUG_DRIVER(dev, "sha1_input: 0x%*ph",
> @@ -2251,12 +2290,11 @@ static void it6505_link_training_work(struct work=
_struct *work)
>         if (ret) {
>                 it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
>                 it6505_link_train_ok(it6505);
> -               return;
>         } else {
>                 it6505->auto_train_retry--;
> +               it6505_dump(it6505);
>         }
>
> -       it6505_dump(it6505);
This modification is already done in commit 484436ec5c2b ("drm/bridge:
it6505: fix hibernate to resume no display issue"). Please rebase your
patch.
>  }
>
>  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> @@ -2311,14 +2349,22 @@ static int it6505_process_hpd_irq(struct it6505 *=
it6505)
>         DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector =3D 0x%02x", dp_irq_vect=
or);
>
>         if (dp_irq_vector & DP_CP_IRQ) {
> -               it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CP=
IRQ,
> -                               HDCP_TRIGGER_CPIRQ);
>
Remove this blank line as well.
>                 bstatus =3D it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS)=
;
>                 if (bstatus < 0)
>                         return bstatus;
>
>                 DRM_DEV_DEBUG_DRIVER(dev, "Bstatus =3D 0x%02x", bstatus);
> +
> +               /*1B-02 ignore when bstatus is 0 */
> +               if ((bstatus & DP_BSTATUS_R0_PRIME_READY) &&
> +                               (it6505->hdcp_status =3D=3D HDCP_AUTH_GOI=
NG))
> +                       it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TR=
IGGER_CPIRQ,
> +                                       HDCP_TRIGGER_CPIRQ);
> +               else if ((bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_L=
INK_FAILURE)) &&
> +                               (it6505->hdcp_status =3D=3D HDCP_AUTH_DON=
E))
> +                       it6505_start_hdcp(it6505);
> +
>         }
>
>         ret =3D drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
> @@ -2431,7 +2477,7 @@ static void it6505_irq_hdcp_done(struct it6505 *it6=
505)
>
>         DRM_DEV_DEBUG_DRIVER(dev, "hdcp done interrupt");
>         it6505->hdcp_status =3D HDCP_AUTH_DONE;
> -       it6505_show_hdcp_info(it6505);
> +       it6505_show_hdcp_info(it6505, false);
>  }
>
>  static void it6505_irq_hdcp_fail(struct it6505 *it6505)
> @@ -2440,7 +2486,7 @@ static void it6505_irq_hdcp_fail(struct it6505 *it6=
505)
>
>         DRM_DEV_DEBUG_DRIVER(dev, "hdcp fail interrupt");
>         it6505->hdcp_status =3D HDCP_AUTH_IDLE;
> -       it6505_show_hdcp_info(it6505);
> +       it6505_show_hdcp_info(it6505, true);
>         it6505_start_hdcp(it6505);
>  }
>
> @@ -2455,7 +2501,11 @@ static void it6505_irq_hdcp_ksv_check(struct it650=
5 *it6505)
>  {
>         struct device *dev =3D &it6505->client->dev;
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
> +       DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
> +
> +       it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> +                       HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
> +
>         schedule_work(&it6505->hdcp_wait_ksv_list);
>  }
>
> --
> 2.34.1
>

Regards,
Pin-yen

