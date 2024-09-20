Return-Path: <linux-kernel+bounces-334016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C853597D169
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ACA1F24E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891AE3BB50;
	Fri, 20 Sep 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4HsD9UY"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FC2746C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815633; cv=none; b=ros/1DWozEgAPAu+c0PSSb4a5tEVemiXQgapiWFqrJqBk7SD8eT4MCxm8kAO6SSU03C4FH65D7pVW/ks5yZNTxwisR8JFLk/kloU5gkP73AcoOpu7ESF9GU4QwBnf/VczDjtYJ6rjHzqe8jhAieersBhVNRbgWS6+OBFz/nh32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815633; c=relaxed/simple;
	bh=VkxNiTxx/coc+R/TDW5h1SoIUfSfzv1zI5XE9EMnQkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq0g15FMhXSBNuJVThigvdsWvBvoDwnysJ7UZ4SK85EeJX1tZFNzRqN+Oyv8y9F5t+VoUtvbLQsBoE/k+txKIY6Npp4pfep7hMg/JBzSNgoeHOksSlMtPp7I4v70sw3DzK/uV1p7ALtaVJXulIvhg4zzfZjRKCLdRk+yCYqHrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d4HsD9UY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-710dad96bf7so529101a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726815630; x=1727420430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKh8jp1mMqMC44NuYUrSIonMZomeZP474HQjy5D5RNU=;
        b=d4HsD9UYgba0ENkMCJ6GB44Z+OPyWVOliZf6giroyB6iNr5IVk4n3XHvEvLzH9/2Oz
         3nzH/9v0L8DtrTPvJFGPymBXZhZJsenOwBYn/eS4JkrbpcxJ4IL5MODRdpAvkRPq7WZ8
         6zTzPRUDjNG9o/4/t4P19F8qhycI20CCgw1sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726815630; x=1727420430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKh8jp1mMqMC44NuYUrSIonMZomeZP474HQjy5D5RNU=;
        b=Kfv7EEfii8DoW4Zdrig1HJUHYJovewEJnAJpyBoFU0Yv+hHarhdJ91zzeZOH3gim3X
         IOhd5HwsUkCAsPd6jWukbbouZ8P8d8SvY+S8GLW9tHwz3chKwljuMkfjTkg2Vs527X7B
         CVCmYegaU9nv8qs+2PK3YU0ROqTN9hmk9UQg7YBuqjQubZGIdPn8lncjeBXEhaMOGgCp
         rUKXKO9x5u62xOOMI8vU/NN8m+njJKzRTPX71x+JeL35tfQScBs4c39vhlcf6x2YnmaS
         JTPhMPjrkqVg4drM2tRHhTHHjxEnZcshS6F2yBi55Wnu1fS1FxfTQRTk1w6UdpUNjhdo
         olQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwd5YTs0uktm7YEqwL1qEwSIcij8TT6PJB1H7j+qPO2jDmT2OYe4zKN621TOh9mwagHFx1erD/y91TNqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyhUbvXTut8cfHjC8ECHTBHmxXN+nBYk40bJ0xSost9cgmmQZ
	2dDDjbSoRuMMNrPpHss2/Mp79FLlWI+ktEQOfTJdqBHhfgEPryhu5F2HlzatA1qAyAq8sbin3TV
	DJ8cK2kyPA8Id1E+u74SQXbaP0muUNymMupit
X-Google-Smtp-Source: AGHT+IEsTYGcuuUXnvPDwkMrHq210zYf5pcO0Ki2WJlh5mhv/fkHgu4HSUPRWVms56Bpzzfplk5t/rpEwDgFlajeOII=
X-Received: by 2002:a05:6830:71a7:b0:711:1503:85a0 with SMTP id
 46e09a7af769-713923b0ecbmr1360535a34.5.1726815630555; Fri, 20 Sep 2024
 00:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091916.1484-1-Hermes.Wu@ite.com.tw> <20240919091916.1484-3-Hermes.Wu@ite.com.tw>
In-Reply-To: <20240919091916.1484-3-Hermes.Wu@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 20 Sep 2024 15:00:19 +0800
Message-ID: <CAEXTbpf8V3h0reTbsopY1ifCq4a4V44OJyhk=zRnwhBayMte1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/bridge: it6505: Add MSSC suport
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>, Kenneth Hung <Kenneth.hung@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:20=E2=80=AFPM Hermes Wu <Hermes.Wu@ite.com.tw> wr=
ote:
>
> From: "Hermes.Wu" <Hermes.wu@ite.com.tw>
>
> add AUX-I2C functionality to support MCCS.
>
> Change-Id: I63e1a0e5da67526f89f35605a82944be67dee8ac
Remove the Change-Id line. If you run scripts/checkpatch.pl, the
script should catch this for you.

> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 209 ++++++++++++++++++++++++++--
>  1 file changed, 200 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index cef02c8c363e..1a272c67e82b 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -127,6 +127,9 @@
>  #define REG_AUX_ADR_16_19 0x26
>  #define REG_AUX_OUT_DATA0 0x27
>
> +#define REG_AUX_I2C_ADR 0x25
> +#define REG_AUX_I2C_OP 0x26
> +
>  #define REG_AUX_CMD_REQ 0x2B
>  #define AUX_BUSY BIT(5)
>
> @@ -268,6 +271,19 @@
>  #define REG_SSC_CTRL1 0x189
>  #define REG_SSC_CTRL2 0x18A
>
> +#define REG_AUX_USER_CTRL 0x190
> +#define EN_USER_AUX BIT(0)
> +#define USER_AUX_DONE BIT(1)
> +#define AUX_EVENT BIT(4)
> +
> +#define REG_AUX_USER_DATA_REC 0x191
> +#define M_AUX_IN_REC   0xF0
> +#define M_AUX_OUT_REC  0x0F
> +
> +#define REG_AUX_USER_TXB 0x190
> +#define REG_AUX_USER_REPLY 0x19A
> +#define REG_AUX_USER_RXB(n) (n + 0x19B)
> +
>  #define RBR DP_LINK_BW_1_62
>  #define HBR DP_LINK_BW_2_7
>  #define HBR2 DP_LINK_BW_5_4
> @@ -303,6 +319,8 @@
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
>  #define AUX_FIFO_MAX_SIZE 16
> +#define AUX_I2C_MAX_SIZE 4
> +#define AUX_I2C_DEFER_RETRY 4
>  #define PIXEL_CLK_DELAY 1
>  #define PIXEL_CLK_INVERSE 0
>  #define ADJUST_PHASE_THRESHOLD 80000
> @@ -325,7 +343,12 @@
>  enum aux_cmd_type {
>         CMD_AUX_NATIVE_READ =3D 0x0,
>         CMD_AUX_NATIVE_WRITE =3D 0x5,
> +       CMD_AUX_GI2C_ADR =3D 0x08,
> +       CMD_AUX_GI2C_READ =3D 0x09,
> +       CMD_AUX_GI2C_WRITE =3D 0x0A,
>         CMD_AUX_I2C_EDID_READ =3D 0xB,
> +       CMD_AUX_I2C_READ =3D 0x0D,
> +       CMD_AUX_I2C_WRITE =3D 0x0C,
>
>         /*extend read ncommand */
>         CMD_AUX_GET_KSV_LIST =3D 0x10,
> @@ -333,8 +356,11 @@ enum aux_cmd_type {
>
>  enum aux_cmd_reply {
>         REPLY_ACK,
> -       REPLY_NACK,
> -       REPLY_DEFER,
> +       REPLY_NACK =3D 1,
> +       REPLY_DEFER =3D 2,
> +
> +       REPLY_I2C_NACK =3D 4,
> +       REPLY_I2C_DEFER =3D 8,
>  };
>
>  enum link_train_status {
> @@ -1087,7 +1113,6 @@ static ssize_t it6505_aux_do_transfer(struct it6505=
 *it6505,
>                                       size_t size, enum aux_cmd_reply *re=
ply)
>  {
>         int i, ret_size, ret =3D 0, request_size;
> -       struct device *dev =3D &it6505->client->dev;
The drm-misc/drm-misc-next doesn't have it6505->client node. It's
already removed at commit d65feac281ab ("drm/bridge: Remove redundant
i2c_client in anx7625/it6505").

Please rebase your patch.
>
>         mutex_lock(&it6505->aux_lock);
>         for (i =3D 0; i < size; ) {
> @@ -1114,6 +1139,168 @@ static ssize_t it6505_aux_do_transfer(struct it65=
05 *it6505,
>         return ret;
>  }
>
> +
> +static int it6505_aux_i2c_wait(struct it6505 *it6505, u8 *reply)
> +{
> +       int err =3D 0;
> +       unsigned long timeout;
> +       struct device *dev =3D &it6505->client->dev;
> +
> +       timeout =3D jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
> +
> +       do {
> +               if (it6505_read(it6505, REG_AUX_USER_CTRL) & AUX_EVENT)
Do we need to assign err if it6505_read returns error?
> +                       break;
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(dev, "Timed out waiting AUX I2C, BUSY =3D=
 %X\n",
> +                                       it6505_aux_op_finished(it6505));
> +                       err =3D -ETIMEDOUT;
> +                       goto end_aux_i2c_wait;
> +               }
> +               usleep_range(300, 800);
> +
> +       } while (!it6505_aux_op_finished(it6505));
Can this loop be changed to regmap_read_poll_timeout()?
> +
> +       if (reply =3D=3D NULL)
> +               goto end_aux_i2c_wait;
If reply is NULL, then there will be a NULL pointer dereference at
it6505_aux_i2c_readb() anyway. From the usages in drm_dp_helper.c, I
doubt if this pointer is possible to be NULL. Even if it could, you
should have done this check earlier.
> +
> +       *reply =3D it6505_read(it6505, REG_AUX_USER_REPLY) >> 4;
> +
> +       if (*reply =3D=3D 0)
> +               goto end_aux_i2c_wait;
> +
> +       if ((*reply =3D=3D DP_AUX_NATIVE_REPLY_DEFER) ||
> +                       (*reply =3D=3D DP_AUX_I2C_REPLY_DEFER))
> +               err =3D -EBUSY;
> +       else if ((*reply =3D=3D DP_AUX_NATIVE_REPLY_NACK) ||
> +                       (*reply =3D=3D DP_AUX_I2C_REPLY_NACK))
> +               err =3D -ENXIO;
> +
> +end_aux_i2c_wait:
> +       it6505_set_bits(it6505, REG_AUX_USER_CTRL, USER_AUX_DONE, USER_AU=
X_DONE);
> +       return err;
> +}
> +
> +static int it6505_aux_i2c_readb(struct it6505 *it6505, u8 *buf, size_t s=
ize, u8 *reply)
> +{
> +       int ret, i;
> +       int retry =3D 0;
> +
> +       for (retry =3D 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
> +
Remove the blank line here.
> +               it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_READ);
> +
> +               ret =3D it6505_aux_i2c_wait(it6505, reply);
> +
> +               if ((*reply =3D=3D DP_AUX_NATIVE_REPLY_DEFER) ||
> +                       (*reply =3D=3D DP_AUX_I2C_REPLY_DEFER))
> +                       continue;
> +
> +               if (ret >=3D 0)
> +                       break;
Should we check the return value before checking the reply?
> +       }
> +
> +       for (i =3D 0; i < size; i++)
> +               buf[i] =3D  (u8) it6505_read(it6505, REG_AUX_USER_RXB(0 +=
 i));
> +
> +       return size;
> +}
> +
> +static int it6505_aux_i2c_writeb(struct it6505 *it6505, u8 *buf, size_t =
size, u8 *reply)
> +{
> +       int i, ret;
> +       int retry =3D 0;
> +
> +       for (i =3D 0; i < size; i++)
> +               it6505_write(it6505, REG_AUX_OUT_DATA0 + i, buf[i]);
> +
> +       for (retry =3D 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
> +
ditto
> +               it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_WRITE)=
;
> +
> +               ret =3D it6505_aux_i2c_wait(it6505, reply);
> +
> +               if ((*reply =3D=3D DP_AUX_NATIVE_REPLY_DEFER) ||
> +                       (*reply =3D=3D DP_AUX_I2C_REPLY_DEFER))
> +                       continue;
> +
> +               if (ret >=3D 0)
> +                       break;
ditto
> +       }
> +       return size;
> +}
> +
> +static ssize_t it6505_aux_i2c_operation(struct it6505 *it6505,
> +                                       struct drm_dp_aux_msg *msg)
> +{
> +       int ret;
> +       ssize_t request_size, data_cnt =3D 0;
> +       struct device *dev =3D &it6505->client->dev;
> +       u8 *buffer =3D msg->buffer;
> +
> +       /* set AUX user mode */
> +       it6505_set_bits(it6505, REG_AUX_CTRL,
> +                       AUX_USER_MODE | AUX_NO_SEGMENT_WR, AUX_USER_MODE)=
;
> +       it6505_set_bits(it6505, REG_AUX_USER_CTRL, EN_USER_AUX, EN_USER_A=
UX);
> +       /* clear AUX FIFO */
> +       it6505_set_bits(it6505, REG_AUX_CTRL,
> +                       AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> +                       AUX_EN_FIFO_READ | CLR_EDID_FIFO);
> +
> +       it6505_set_bits(it6505, REG_AUX_CTRL,
> +                       AUX_EN_FIFO_READ | CLR_EDID_FIFO, 0x00);
> +
> +       it6505_write(it6505, REG_AUX_ADR_0_7, 0x00);
> +       it6505_write(it6505, REG_AUX_I2C_ADR, msg->address << 1);
> +
> +       if (msg->size =3D=3D 0) {
> +               /* IIC Start/STOP dummy write */
> +               it6505_write(it6505, REG_AUX_I2C_OP, msg->request);
> +               it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_ADR);
> +               ret =3D it6505_aux_i2c_wait(it6505, &msg->reply);
> +               goto end_aux_i2c_transfer;
> +       }
> +
> +       /* IIC data transfer */
> +       for (data_cnt =3D 0; data_cnt < msg->size; ) {
> +               request_size =3D min(msg->size - data_cnt, AUX_I2C_MAX_SI=
ZE);
> +               it6505_write(it6505, REG_AUX_I2C_OP,
> +                                       (msg->request) | ((request_size -=
 1) << 4));
> +
> +               if ((msg->request & DP_AUX_I2C_READ) =3D=3D DP_AUX_I2C_RE=
AD)
> +                       ret =3D it6505_aux_i2c_readb(it6505, &buffer[data=
_cnt],
> +                                                       request_size, &ms=
g->reply);
> +               else
> +                       ret =3D it6505_aux_i2c_writeb(it6505, &buffer[dat=
a_cnt],
> +                                                       request_size, &ms=
g->reply);
> +
Remove the blank line here. I don't think we need a blank line before
the return value check.
> +               if (ret < 0)
> +                       goto end_aux_i2c_transfer;
> +
> +               data_cnt +=3D request_size;
> +       }
> +       ret =3D data_cnt;
> +end_aux_i2c_transfer:
> +
Remove the blank line.
> +       it6505_set_bits(it6505, REG_AUX_USER_CTRL, EN_USER_AUX, 0);
> +       it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, 0);
> +       return ret;
> +}
> +
> +
Remove one blank line.
> +static ssize_t it6505_aux_i2c_transfer(struct drm_dp_aux *aux,
> +                                  struct drm_dp_aux_msg *msg)
> +{
> +       struct it6505 *it6505 =3D container_of(aux, struct it6505, aux);
> +       int ret;
> +
> +       mutex_lock(&it6505->aux_lock);
> +       ret =3D it6505_aux_i2c_operation(it6505, msg);
> +       mutex_unlock(&it6505->aux_lock);
> +       return ret;
> +}
> +
> +
ditto.
>  static ssize_t it6505_aux_transfer(struct drm_dp_aux *aux,
>                                    struct drm_dp_aux_msg *msg)
>  {
> @@ -1125,7 +1312,7 @@ static ssize_t it6505_aux_transfer(struct drm_dp_au=
x *aux,
>
>         /* IT6505 doesn't support arbitrary I2C read / write. */
Update the comment above.
>         if (is_i2c)
> -               return -EINVAL;
> +               return it6505_aux_i2c_transfer(aux, msg);
>
>         switch (msg->request) {
>         case DP_AUX_NATIVE_READ:
> @@ -1153,6 +1340,8 @@ static ssize_t it6505_aux_transfer(struct drm_dp_au=
x *aux,
>         case REPLY_DEFER:
>                 msg->reply =3D DP_AUX_NATIVE_REPLY_DEFER;
>                 break;
> +       default:
> +               break;
>         }
>
>         return ret;
> @@ -1180,7 +1369,7 @@ static int it6505_get_edid_block(void *data, u8 *bu=
f, unsigned int block,
>                 switch (reply) {
>                 case REPLY_ACK:
>                         DRM_DEV_DEBUG_DRIVER(dev, "[0x%02x]: %8ph", offse=
t,
> -                                            buf + offset);
> +                                                               uf + offs=
et);
This looks like a typo to me.
>                         offset +=3D 8;
>                         aux_retry =3D 100;
>                         break;
> @@ -1190,6 +1379,8 @@ static int it6505_get_edid_block(void *data, u8 *bu=
f, unsigned int block,
>                         msleep(20);
>                         if (!(--aux_retry))
>                                 return -EIO;
> +               default:
> +                       break;
>                 }
>         }
>
> @@ -2031,8 +2222,8 @@ static int it6505_setup_sha1_input(struct it6505 *i=
t6505, u8 *sha1_input)
>
>
>         err =3D  it6505_get_ksvlist(it6505, sha1_input, down_stream_count=
 * 5);
> -       if (err < 0)
> -               return err;
> +               if (err < 0)
> +                       return err;
Revert the indentation change here.
>
>         msg_count +=3D down_stream_count * 5;
>
> @@ -2075,7 +2266,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct =
it6505 *it6505)
>         for (retry =3D 0; retry < 3; retry++) {
>
>                 err =3D it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (=
u8 *)bv,
> -                                       sizeof(bv));
> +                             sizeof(bv));
Same here.
>
>                 if (err < 0) {
>                         dev_err(dev, "Read V' value Fail %d", retry);
> @@ -2126,7 +2317,7 @@ static void it6505_hdcp_wait_ksv_list(struct work_s=
truct *work)
>
>         ksv_list_check =3D it6505_hdcp_part2_ksvlist_check(it6505);
>         DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
> -                               ksv_list_check ? "pass" : "fail");
> +                            ksv_list_check ? "pass" : "fail");
The indentation here is correct on my drm-misc/drm-misc-next checkout.
Please rebase your patch and revisit this.

>
>         if (ksv_list_check)
>                 return;
> --
> 2.34.1
>

Regards,
Pin-yen

