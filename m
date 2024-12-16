Return-Path: <linux-kernel+bounces-447678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A29F35F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC301188AAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A31898F2;
	Mon, 16 Dec 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYS4w2kv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE39200A0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366350; cv=none; b=rrq3S3x6CgqM1Ncahew79iqQLMdAiefOR0fblK+6GKNjQUhLB0TFhcen2+L2orfDOnM6ij6KKXPDolxMXKJNLnPJItQegH5bDb1fRZxJYH8GvVa2jYpMbvZKlBbGiv3xJXQ+zDr/I3H30b0uEHo9ClvrfUjEcu2tZmVCMqqmz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366350; c=relaxed/simple;
	bh=JbvsiqJHkNXY6BJf9zPoKcSEUY/h6OwHRlQi+0L36WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5Y5aA/o8oikiutS+CDOtDk0BChWV4VZ0f5ko6tSOvUN5f6xqfBevSRU7sNHTn/wYkWhFk7x4FzpxMfjnRdmSz2q8mAl22jJPExbvxGNT8UoGCFdTvwtppgcL/eRTsXJIQirbLcLr8mD60owNYJYctRdYzmXeHtE3QuWQ/5dMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYS4w2kv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385eed29d17so2173548f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366347; x=1734971147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1JBC0yzglAUTPJPyRXxDLADQI+3/EsK5xxpb/QppY0=;
        b=MYS4w2kvo1uCFzmR1PM0BegT0ZaZo145EtC1S69Zs6WCk3xIbJ1iGwn24HDRbAQbF9
         nvmr9JSDlWBjsoaoKqlTouJue18d4Gfs2vqx2gLVXo4U2SxVxpCwRz2949yrvyrfeNOO
         7lRQYK6+EetQUNdNlOzMs8R9BZvFkYbiXk/3hiFYqQ6IrdQXkkvWqWm568Z2mCs7cBmX
         ml5UQWlm2zrEREJcqfhcQnEohO3Kmpo3EZ1uHoo94J6iuJxhfAnEspW+B3c/SKoZbOmL
         akbcp7sk/k0EscowB76qv89ZxOoLafB+vyX3Ptn0U8CjlkdFWuYzlb03e16cLOOVR1OY
         +WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366347; x=1734971147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1JBC0yzglAUTPJPyRXxDLADQI+3/EsK5xxpb/QppY0=;
        b=ETGoVjIn1wgwrtwjrjZbCImK3AInbI1YCg9xMTW+mhwWVFLhix9z4yX3uJdC2CNgfA
         bM4orUL9LCiUBN6VcES4GDwcOZ6IZU58c49YtHUJlYDwkxqJESOfBnmAb6FVuCZAjEC/
         H6v23RjHLzUqZRH7/jtOhzlu9CgHGqz3M5zf/viQjRSvW4JrpfGPYyvMbUJyT7ySLGFf
         br/fPbdJPXgnGYWPrNXOpO5rFdROgkjtB1bgK7Cy7w/aOgNxjj9tt7CkSusAPjcNnc7+
         qcBKDO6cpu0TK0Vq2gTkms6MiRl8tc6Tc3hLh+2nvuvuJ7izylLA7hM/aTsMNR+hvBZq
         fx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI/mLh+ZaDRyQJBGJ6xnRnrj515WdyOBYe/9zGySEOu58zc/L7qomV41e4Qj6hGTPAzMDGDrpe/zp91RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnO8GGOtE+jbSdVhFrAOJdmysQHIK2dFZ8mwct9A1+v24/PMi
	TLcy+4qZT/jbYhVpWDfWHxgR15B8Ww8BO4/IqgTR9nLk7SVBe9eQLRhj64y3eiMqHgQvKN6/f84
	Y/TJcwxfTfJdwX3vUwNX0SnbmDQapinau+SKF
X-Gm-Gg: ASbGncteZgZpEajoFJ9mQwv6UQwaPiKw+dBCa9gOBwuxSu36FLGbMbynHmb424yk1iL
	CHjOA0HdmdD0nqOYSlVfcQvrP4BtREZYxe8vzbes09/yWJWCaA59p2+oI28LDgKixS3oAlg==
X-Google-Smtp-Source: AGHT+IHRTldSp79yqNLLeq6Qq+q+4KGHMflo1B58ysZ6ESeNK5Ivs7mdObG/TtxwHRV+DFXh7Xiji2PO9c1XmyQwkC4=
X-Received: by 2002:a5d:584c:0:b0:386:4a0d:bb21 with SMTP id
 ffacd0b85a97d-38880acda4cmr9693116f8f.22.1734366346756; Mon, 16 Dec 2024
 08:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212233333.3743239-1-brianvv@google.com> <20241212233333.3743239-4-brianvv@google.com>
 <bc95ab79-6b4a-41be-b5b7-daaec04f23d0@molgen.mpg.de>
In-Reply-To: <bc95ab79-6b4a-41be-b5b7-daaec04f23d0@molgen.mpg.de>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 16 Dec 2024 11:25:35 -0500
Message-ID: <CAMzD94QaBxYF_oqrWTKG1a2gHWbaeHEcCguENRTpgaiJbQXZ9w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-next PATCH v3 3/3] idpf: add more info
 during virtchnl transaction time out
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Manoj Vishwanathan <manojvishy@google.com>, Brian Vazquez <brianvv.kernel@gmail.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Jacob Keller <jacob.e.keller@intel.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, I will address it in the next version.

On Fri, Dec 13, 2024 at 4:36=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Brian, dear Manoj,
>
>
> Thank you for your patch.
>
> Am 13.12.24 um 00:33 schrieb Brian Vazquez:
> > From: Manoj Vishwanathan <manojvishy@google.com>
> >
> > Add more information related to the transaction like cookie, vc_op,
> > salt when transaction times out and include similar information
> > when transaction salt does not match.
>
> If possible, the salt mismatch should also go into the summary/title. May=
be:
>
> idpf: Add more info during virtchnl transaction timeout/salt mismatch
>
> > Info output for transaction timeout:
> > -------------------
> > (op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
> > -------------------
>
> For easier comparison, before it was:
>
> (op 5015, 60000ms)
>
> > Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/=
net/ethernet/intel/idpf/idpf_virtchnl.c
> > index 13274544f7f4..c7d82f142f4e 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -517,8 +516,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter=
 *adapter,
> >               retval =3D -ENXIO;
> >               goto only_unlock;
> >       case IDPF_VC_XN_WAITING:
> > -             dev_notice_ratelimited(&adapter->pdev->dev, "Transaction =
timed-out (op %d, %dms)\n",
> > -                                    params->vc_op, params->timeout_ms)=
;
> > +             dev_notice_ratelimited(&adapter->pdev->dev,
> > +                                    "Transaction timed-out (op:%d cook=
ie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
> > +                                    params->vc_op, cookie, xn->vc_op,
> > +                                    xn->salt, params->timeout_ms);
> >               retval =3D -ETIME;
> >               break;
> >       case IDPF_VC_XN_COMPLETED_SUCCESS:
> > @@ -615,8 +613,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapt=
er,
> >       idpf_vc_xn_lock(xn);
> >       salt =3D FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
> >       if (xn->salt !=3D salt) {
> > -             dev_err_ratelimited(&adapter->pdev->dev, "Transaction sal=
t does not match (%02x !=3D %02x)\n",
> > -                                 xn->salt, salt);
> > +             dev_err_ratelimited(&adapter->pdev->dev, "Transaction sal=
t does not match (exp:%d@%02x(%d) !=3D got:%d@%02x)\n",
> > +                                 xn->vc_op, xn->salt, xn->state,
> > +                                 ctlq_msg->cookie.mbx.chnl_opcode, sal=
t);
> >               idpf_vc_xn_unlock(xn);
> >               return -EINVAL;
> >       }
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

