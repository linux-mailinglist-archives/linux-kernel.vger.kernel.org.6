Return-Path: <linux-kernel+bounces-171594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1198BE630
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1EE28DF84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8C15FA9F;
	Tue,  7 May 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSxwE3jK"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820D15FA74
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092674; cv=none; b=R6eJMTvca/GA+zMzSkSjjN6mempPu6pIltGpgiVFs5ezaWC+CJC0Q2i8sPTpmxJWd85Jd6xMFmHBZd5u8oIp0YmuRifIdDT+QR9Dmjq+EVQ3rpI8RnQ7zxfYho3phxdgLjVO9VrW8HBYDY0zN65NloMDaB6TwP9DwFDje1mzyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092674; c=relaxed/simple;
	bh=dIUOrSAIHdN021aT4jUnSjW6nNXUU6fCmRhcBGP9zbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrucMsjhPh1IqtsOeVeXm6nK0pVKaFk5llAJg8LQRmrckKuwq6bHatWBeVe1ZbRUg4UzWEA3KvmNS4OToyIg9STdGHANHvMOtC+D3ottayY8OnGJupSstZzW25ofT2AIN52XRTgssOW7fbjHms+EEtKnoYYQz/RODHLWzpy0eYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jSxwE3jK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f049ddd7dso263928785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715092672; x=1715697472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfoakoCRXp8NuHbtuDoi6TSXe/02ySjJzEnJ69B3Tag=;
        b=jSxwE3jKaF6cTd955SGc++FeyJvo/qXViSng1zcglz8J5vYsJRIWHJecWObtkQCEEn
         22pizCzYKQ1dtMt4NTRa9VwmgiO7LhW0A7/AviOQZarlnRSVaOUF8tBOEa42LEcVZrgk
         sdzWTejfCaGvbjOMWDR5FN7LprPiahQavvv+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092672; x=1715697472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfoakoCRXp8NuHbtuDoi6TSXe/02ySjJzEnJ69B3Tag=;
        b=ehBBqGo4eMpt9pd06kd//1WVT7iK4bHH1B9/hESG377awuTLKj+fEFYs2uISUs+qcc
         imTa0WPPfN8YBYdMgOIXYNfQSGVByGQT02htmyoppLD7uH+OTfBEogiqvxdBMdkKaTLS
         ZyYUjY5arFnOllJu2VoeEwa/+Wj4+nA/JkTDskTg9qAKWaFMrCpnDxNQjyQd7REctSxj
         b7q0aF0CWBFN5DRd3U7y9zef7dfoRrNNsfWqdU6e/DkM/Nu5YxD5z7vMNVkDWeC2NmsA
         qoHsDAoHzjS+GNutmjT/HskSMGTer6s97aL5+Wr1XZKYbI6Z9XnrALyLr9fnkXgWNPXB
         inQw==
X-Forwarded-Encrypted: i=1; AJvYcCVIKli+Y8KFlK390Lg8hOjgFWz0q+jdG7+vA+fE0aSp/P2/QvspkWLqhVSyUYhWVQcYTEpuWi87UQBrUCz4Xo3mVeLT0PNwj/USclJN
X-Gm-Message-State: AOJu0Yy6BPtCxKl7JyRr4Iuv5ndYMFGw18K7aBm/NKLP3UcFfeUUm7wE
	NxgrA/N1NLgLjDjDVT57utO/2uSRsu5cdXJc4OpnnBda8Or2RIfg4a/VciClMX7gkUOtXxJ1pXa
	O2w==
X-Google-Smtp-Source: AGHT+IEl7BbR4sJtFxdXLTfcGpuYaBzDj6fcao0R/pbNsjFzY4cyZYW5KdJMgGaXCpaOSIqbe324bg==
X-Received: by 2002:a05:620a:5dd6:b0:792:9d4c:6431 with SMTP id xy22-20020a05620a5dd600b007929d4c6431mr5105808qkn.56.1715092671741;
        Tue, 07 May 2024 07:37:51 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id t29-20020a05620a035d00b007929be68937sm1812172qkm.108.2024.05.07.07.37.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:37:51 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792940cc710so235682185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:37:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgSLyuLMzSWHhUyOQywBUOb6Vvk2ltJfRLaEOAQlUmZbCwNnOMXrX7+ZQACh2lE+ysYDXG/oVStrEL2Fp17RMRdyS0U70DVx54iOOc
X-Received: by 2002:a05:6808:23cb:b0:3c9:6f9c:4abf with SMTP id
 bq11-20020a05680823cb00b003c96f9c4abfmr5962885oib.32.1715092319135; Tue, 07
 May 2024 07:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org> <20240507-cocci-flexarray-v1-6-4a421c21fd06@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v1-6-4a421c21fd06@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 7 May 2024 16:31:43 +0200
X-Gmail-Original-Message-ID: <CANiDSCv==iq+pj18m891AqTYaq1M+QjyE0R=4NQKUK8BmSi7Qw@mail.gmail.com>
Message-ID: <CANiDSCv==iq+pj18m891AqTYaq1M+QjyE0R=4NQKUK8BmSi7Qw@mail.gmail.com>
Subject: Re: [PATCH 06/18] media: siano: Refactor struct sms_msg_data
To: Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi,

The CI has found a build error in ppc for this patch.

https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1171798/test_report?job_name=build

Will send a v2 shortly

On Tue, 7 May 2024 at 15:18, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace a single element array with a single element field.
>
> This fixes the following cocci warning:
> drivers/media/common/siano/smscoreapi.h:619:5-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/common/siano/smscoreapi.c  | 10 +++++-----
>  drivers/media/common/siano/smscoreapi.h  |  2 +-
>  drivers/media/common/siano/smsdvb-main.c |  4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/common/siano/smscoreapi.c b/drivers/media/common/siano/smscoreapi.c
> index 7ebcb10126c9..b6f1eb5dbbdf 100644
> --- a/drivers/media/common/siano/smscoreapi.c
> +++ b/drivers/media/common/siano/smscoreapi.c
> @@ -839,7 +839,7 @@ static int smscore_configure_board(struct smscore_device_t *coredev)
>                 mtu_msg.x_msg_header.msg_flags = 0;
>                 mtu_msg.x_msg_header.msg_type = MSG_SMS_SET_MAX_TX_MSG_LEN_REQ;
>                 mtu_msg.x_msg_header.msg_length = sizeof(mtu_msg);
> -               mtu_msg.msg_data[0] = board->mtu;
> +               mtu_msg.msg_data = board->mtu;
>
>                 coredev->sendrequest_handler(coredev->context, &mtu_msg,
>                                              sizeof(mtu_msg));
> @@ -852,7 +852,7 @@ static int smscore_configure_board(struct smscore_device_t *coredev)
>                 SMS_INIT_MSG(&crys_msg.x_msg_header,
>                                 MSG_SMS_NEW_CRYSTAL_REQ,
>                                 sizeof(crys_msg));
> -               crys_msg.msg_data[0] = board->crystal;
> +               crys_msg.msg_data = board->crystal;
>
>                 coredev->sendrequest_handler(coredev->context, &crys_msg,
>                                              sizeof(crys_msg));
> @@ -1306,7 +1306,7 @@ static int smscore_init_device(struct smscore_device_t *coredev, int mode)
>         msg = (struct sms_msg_data *)SMS_ALIGN_ADDRESS(buffer);
>         SMS_INIT_MSG(&msg->x_msg_header, MSG_SMS_INIT_DEVICE_REQ,
>                         sizeof(struct sms_msg_data));
> -       msg->msg_data[0] = mode;
> +       msg->msg_data = mode;
>
>         rc = smscore_sendrequest_and_wait(coredev, msg,
>                         msg->x_msg_header. msg_length,
> @@ -1394,7 +1394,7 @@ int smscore_set_device_mode(struct smscore_device_t *coredev, int mode)
>
>                         SMS_INIT_MSG(&msg->x_msg_header, MSG_SMS_INIT_DEVICE_REQ,
>                                      sizeof(struct sms_msg_data));
> -                       msg->msg_data[0] = mode;
> +                       msg->msg_data = mode;
>
>                         rc = smscore_sendrequest_and_wait(
>                                 coredev, msg, msg->x_msg_header.msg_length,
> @@ -1554,7 +1554,7 @@ void smscore_onresponse(struct smscore_device_t *coredev,
>                         struct sms_msg_data *validity = (struct sms_msg_data *) phdr;
>
>                         pr_debug("MSG_SMS_DATA_VALIDITY_RES, checksum = 0x%x\n",
> -                               validity->msg_data[0]);
> +                               validity->msg_data);
>                         complete(&coredev->data_validity_done);
>                         break;
>                 }
> diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
> index f8789ee0d554..46dc74ac9318 100644
> --- a/drivers/media/common/siano/smscoreapi.h
> +++ b/drivers/media/common/siano/smscoreapi.h
> @@ -616,7 +616,7 @@ struct sms_msg_hdr {
>
>  struct sms_msg_data {
>         struct sms_msg_hdr x_msg_header;
> -       u32 msg_data[1];
> +       u32 msg_data;
>  };
>
>  struct sms_msg_data2 {
> diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
> index d893a0e4672b..44d8fe8b220e 100644
> --- a/drivers/media/common/siano/smsdvb-main.c
> +++ b/drivers/media/common/siano/smsdvb-main.c
> @@ -689,7 +689,7 @@ static int smsdvb_start_feed(struct dvb_demux_feed *feed)
>         pid_msg.x_msg_header.msg_flags = 0;
>         pid_msg.x_msg_header.msg_type  = MSG_SMS_ADD_PID_FILTER_REQ;
>         pid_msg.x_msg_header.msg_length = sizeof(pid_msg);
> -       pid_msg.msg_data[0] = feed->pid;
> +       pid_msg.msg_data = feed->pid;
>
>         return smsclient_sendrequest(client->smsclient,
>                                      &pid_msg, sizeof(pid_msg));
> @@ -711,7 +711,7 @@ static int smsdvb_stop_feed(struct dvb_demux_feed *feed)
>         pid_msg.x_msg_header.msg_flags = 0;
>         pid_msg.x_msg_header.msg_type  = MSG_SMS_REMOVE_PID_FILTER_REQ;
>         pid_msg.x_msg_header.msg_length = sizeof(pid_msg);
> -       pid_msg.msg_data[0] = feed->pid;
> +       pid_msg.msg_data = feed->pid;
>
>         return smsclient_sendrequest(client->smsclient,
>                                      &pid_msg, sizeof(pid_msg));
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>


-- 
Ricardo Ribalda

