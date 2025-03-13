Return-Path: <linux-kernel+bounces-559530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8490A5F511
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876E5189BA24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618762676E9;
	Thu, 13 Mar 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO/KQ+Ht"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85302673A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870773; cv=none; b=apGbLT81gqKKVTHeQMLmaUkJNRbmsDEKRWyFSFypZbHr1h5MciK9AmjX+BAhaWdPxopLE+382Vg/T14Kcf3yvp9czYV9A2V+aBKAdVztrJV+cfoq+/WSzaDw9vNYk6RAw63UL0lxjYXgxMLObeuBhFbAhtuVHeQGhrjJ3UknUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870773; c=relaxed/simple;
	bh=b8PDWFtN7VW1RJ3hnHYp2UvvPQC/mHJQFD/c8LUcmfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp0K3j/Wqus698UQc07YhXg3nGoOdjlhRAjQrfluoT3YmHMzq+3eSzJC+2DkxTsrSlz7SMus6Et5KTGwq8G0vHPlb5LX6oE/0HsOY3cvuPcbC5Tv+d+4CLqA7aOV8cTvm4V9nWir2eXKhZYrScuqEyjfk0gWwMALr+NkouzaW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO/KQ+Ht; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c2ada8264aso413387fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741870771; x=1742475571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogz0107wCBoyIzUm2WAj7fpOqXVECu+Yy2NfUVIc68U=;
        b=eO/KQ+HtZdDvROsS3tzSm54X91i0fxAu6SYrEag+dVS+Qh0NBSLr4yvs8mTNGiXgfg
         m/wBzsVoGzDsKpwmvuB9O6PMpNqDJyo31lXdHSTxV+xTBqY8n/GdNJFCsb3hfa+1IM7F
         2yfgL5NYd+nEycI5xwmJQzgDcXRMjn3YlLDuqCaBKMJOB6Mi+2sQYghzNQyWJBV14tLe
         Tzv0aOesd7u/uk8Xo9iAjpMqkGq+dw/J8QiEXIjHHB9TmUtggXfb0FYO5gPg+W0R9JrZ
         shym8upvBb+5GrKnt4g5GyGtLIyF+2CU7Y2/O4Mi32V6cnMXSZGT5j7VMemWLN9v4orI
         HjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870771; x=1742475571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogz0107wCBoyIzUm2WAj7fpOqXVECu+Yy2NfUVIc68U=;
        b=S6EInEOLN6meNyLkClpo9laXEDWiy2bG3er9dvJ2IjKQnGsK22zejUFjP2SXHQr3mg
         h0JatPQBivcX942ClhwGRrmv+hLoHmOpKXix2S0gKYocDQZPEACtXtG9iDMmX499e6F7
         lFlITdN242Zly/zcuZ2W/be1ovXLoNcm7y61DqIfb5YnsMW588t8CuvJmChrf+7j8yh3
         ji4V3M0DmlKbZ8QZvxeFh2NAVsw25Dfr2ksnwr0eV94jLYq9ie7U3lnIjE7bOgduMw+v
         zmllKzm1+i4ApjiI1tYbpRvZYMPXWfonEdMS4gL0Kb/qz55iUl50KDwOgbdsD9KGORUi
         Qezw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQUDIVEMHrms7r3NjU2oKt01w0xPsbLpKIAqD/S5RNkQqWJYQVOlG33+E3Nxsn2nQ00Zvlgyo3U02NKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweB156q0gmBQP/zav+z+abdLfDtqnbRZJsviSg7lRZ2WKle/gR
	6yk5BVMBpOuWir6gl0uvesMTROxd3N2horR1nE7MB7IQXDMPjsFWqAiNgc0FQEaMsAwfjxHGs8J
	wdfeNVszqNaLM4+vJz4lXehI4nm/b7YPzoiT0jA==
X-Gm-Gg: ASbGncsvturHUPZPNmcvuPXXzHfjBve4YS31T+boQfgn5SRna3Kwc+EdoEyw5JOBtre
	oEq6aMF/2fwQk3MRH3Jg8WcmilMFrrwynOedIVGl6D1etPG421Qhm3yY+X9GG4asRJzGeWdeioj
	SWmuwXtzKf60CBVgd3JNYpv7Jl3CMGbvmegOR4Kg==
X-Google-Smtp-Source: AGHT+IGItCSptJgdqi5J7EXCa3KxRsWFiRKiDQgnBam87NkJB/E9GiLhN92LqYo0B2jLkCw73JHjZOKmigZWv27ieOw=
X-Received: by 2002:a05:6871:7bc1:b0:2c1:6948:d57c with SMTP id
 586e51a60fabf-2c26130ad6amr14089798fac.28.1741870770737; Thu, 13 Mar 2025
 05:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311100130.42169-1-sgarzare@redhat.com> <20250311100130.42169-3-sgarzare@redhat.com>
 <Z9KhlSr7qG6VooeC@sumit-X1>
In-Reply-To: <Z9KhlSr7qG6VooeC@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 13 Mar 2025 13:59:19 +0100
X-Gm-Features: AQ5f1JpCe8iKMCdqjakfodHI5iNtzJeZLgGDZKMlZhl7BPX4pCoHReYZK0TPlmk
Message-ID: <CAHUa44HEpfL8nmG6qZMYUesSJXWUraUmJE_nwFTp5L8qBaC-jA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] tpm/tpm_ftpm_tee: use send_recv() op
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:13=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> + Jens
>
> Hi Stefano,
>
> On Tue, Mar 11, 2025 at 11:01:29AM +0100, Stefano Garzarella wrote:
> > This driver does not support interrupts, and receiving the response is
> > synchronous with sending the command.
> >
> > It used an internal buffer to cache the response when .send() is called=
,
> > and then return it when .recv() is called.
> >
> > Let's simplify the driver by implementing the new send_recv() op, so th=
at
> > we can also remove the 4KB internal buffer used to cache the response.
>
> Looks like a nice cleanup to me but it needs to be tested. Jens, can you
> give this patch a try?
>
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > Note: I don't know how to test this driver, so I just build it.
> > If someone can test it, or tell me how to do, it will be great!

Tested-by: Jens Wiklander <jens.wiklander@linaro.org>

Cheers,
Jens

>
> The fTPM is now maintained as part of OP-TEE project here [1]. The
> instructions to test it on Qemu can be found here [2] as part of CI
> pipeline.
>
> [1] https://github.com/OP-TEE/optee_ftpm
> [2] https://github.com/OP-TEE/optee_ftpm/blob/master/.github/workflows/ci=
.yml
>
> -Sumit
>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.h |  4 --
> >  drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
> >  2 files changed, 21 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftp=
m_tee.h
> > index f98daa7bf68c..72b2f5c41274 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.h
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> > @@ -23,16 +23,12 @@
> >   * @chip:     struct tpm_chip instance registered with tpm framework.
> >   * @state:    internal state
> >   * @session:  fTPM TA session identifier.
> > - * @resp_len: cached response buffer length.
> > - * @resp_buf: cached response buffer.
> >   * @ctx:      TEE context handler.
> >   * @shm:      Memory pool shared with fTPM TA in TEE.
> >   */
> >  struct ftpm_tee_private {
> >       struct tpm_chip *chip;
> >       u32 session;
> > -     size_t resp_len;
> > -     u8 resp_buf[MAX_RESPONSE_SIZE];
> >       struct tee_context *ctx;
> >       struct tee_shm *shm;
> >  };
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftp=
m_tee.c
> > index 139556b21cc6..f0393d843780 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -31,45 +31,19 @@ static const uuid_t ftpm_ta_uuid =3D
> >                 0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
> >
> >  /**
> > - * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
> > - * @chip:    the tpm_chip description as specified in driver/char/tpm/=
tpm.h.
> > - * @buf:     the buffer to store data.
> > - * @count:   the number of bytes to read.
> > - *
> > - * Return:
> > - *   In case of success the number of bytes received.
> > - *   On failure, -errno.
> > - */
> > -static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t=
 count)
> > -{
> > -     struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(chip->dev.p=
arent);
> > -     size_t len;
> > -
> > -     len =3D pvt_data->resp_len;
> > -     if (count < len) {
> > -             dev_err(&chip->dev,
> > -                     "%s: Invalid size in recv: count=3D%zd, resp_len=
=3D%zd\n",
> > -                     __func__, count, len);
> > -             return -EIO;
> > -     }
> > -
> > -     memcpy(buf, pvt_data->resp_buf, len);
> > -     pvt_data->resp_len =3D 0;
> > -
> > -     return len;
> > -}
> > -
> > -/**
> > - * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared m=
emory.
> > + * ftpm_tee_tpm_op_send_recv() - send TPM commands through the TEE sha=
red memory
> > + * and retrieve the response.
> >   * @chip:    the tpm_chip description as specified in driver/char/tpm/=
tpm.h
> > - * @buf:     the buffer to send.
> > - * @len:     the number of bytes to send.
> > + * @buf:     the buffer to send and to store the response.
> > + * @buf_len: the size of the buffer.
> > + * @cmd_len: the number of bytes to send.
> >   *
> >   * Return:
> > - *   In case of success, returns 0.
> > + *   In case of success, returns the number of bytes received.
> >   *   On failure, -errno
> >   */
> > -static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t=
 len)
> > +static int ftpm_tee_tpm_op_send_recv(struct tpm_chip *chip, u8 *buf,
> > +                                  size_t buf_len, size_t cmd_len)
> >  {
> >       struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(chip->dev.p=
arent);
> >       size_t resp_len;
> > @@ -80,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *ch=
ip, u8 *buf, size_t len)
> >       struct tee_param command_params[4];
> >       struct tee_shm *shm =3D pvt_data->shm;
> >
> > -     if (len > MAX_COMMAND_SIZE) {
> > +     if (cmd_len > MAX_COMMAND_SIZE) {
> >               dev_err(&chip->dev,
> >                       "%s: len=3D%zd exceeds MAX_COMMAND_SIZE supported=
 by fTPM TA\n",
> > -                     __func__, len);
> > +                     __func__, cmd_len);
> >               return -EIO;
> >       }
> >
> >       memset(&transceive_args, 0, sizeof(transceive_args));
> >       memset(command_params, 0, sizeof(command_params));
> > -     pvt_data->resp_len =3D 0;
> >
> >       /* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
> >       transceive_args =3D (struct tee_ioctl_invoke_arg) {
> > @@ -103,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chi=
p, u8 *buf, size_t len)
> >               .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> >               .u.memref =3D {
> >                       .shm =3D shm,
> > -                     .size =3D len,
> > +                     .size =3D cmd_len,
> >                       .shm_offs =3D 0,
> >               },
> >       };
> > @@ -115,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chi=
p, u8 *buf, size_t len)
> >               return PTR_ERR(temp_buf);
> >       }
> >       memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> > -     memcpy(temp_buf, buf, len);
> > +     memcpy(temp_buf, buf, cmd_len);
> >
> >       command_params[1] =3D (struct tee_param) {
> >               .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > @@ -156,38 +129,21 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *=
chip, u8 *buf, size_t len)
> >                       __func__, resp_len);
> >               return -EIO;
> >       }
> > +     if (resp_len > buf_len) {
> > +             dev_err(&chip->dev,
> > +                     "%s: Invalid size in recv: buf_len=3D%zd, resp_le=
n=3D%zd\n",
> > +                     __func__, buf_len, resp_len);
> > +             return -EIO;
> > +     }
> >
> > -     /* sanity checks look good, cache the response */
> > -     memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> > -     pvt_data->resp_len =3D resp_len;
> > -
> > -     return 0;
> > -}
> > -
> > -static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
> > -{
> > -     /* not supported */
> > -}
> > -
> > -static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
> > -{
> > -     return 0;
> > -}
> > +     memcpy(buf, temp_buf, resp_len);
> >
> > -static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status=
)
> > -{
> > -     return false;
> > +     return resp_len;
> >  }
> >
> >  static const struct tpm_class_ops ftpm_tee_tpm_ops =3D {
> >       .flags =3D TPM_OPS_AUTO_STARTUP,
> > -     .recv =3D ftpm_tee_tpm_op_recv,
> > -     .send =3D ftpm_tee_tpm_op_send,
> > -     .cancel =3D ftpm_tee_tpm_op_cancel,
> > -     .status =3D ftpm_tee_tpm_op_status,
> > -     .req_complete_mask =3D 0,
> > -     .req_complete_val =3D 0,
> > -     .req_canceled =3D ftpm_tee_tpm_req_canceled,
> > +     .send_recv =3D ftpm_tee_tpm_op_send_recv,
> >  };
> >
> >  /*
> > --
> > 2.48.1
> >
> >

