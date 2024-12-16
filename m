Return-Path: <linux-kernel+bounces-448038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F929F3A31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4B162E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394020C497;
	Mon, 16 Dec 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0uSI67V"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25A207675
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378584; cv=none; b=JUZJ8+aAM+qKCiB4CwwOcYo19+G/BvzL4mFqRSTPX5ItwlcmmigYGGautBqD+jsrquOyWZhSh3IuvOrI6Cf5vRNA3g4n6KhoEx0ft/fJ1tJjRrAq3p3RYWDuinxXxYWCAKnOMCC0FA+3b+7CWYEYjDDiePyLKVilIBvg8WOgP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378584; c=relaxed/simple;
	bh=yiOfUbb5jpBoALuu9emFj0aPP8HuZJFUHwQAFjsas1o=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSX7dGxlcqwxj5aH51TpmlS5I1hzQHU/usvoYyz662eJDhVZI4hhFUpEZkLsgKA9P4sZmByT68aQsPAReS30eiKLy26n8TjMSzY9OuHyh2KcZn2XpDXTR5Mdnij1wMO0t6kiAL+/Cc3RIt8dn7sjwsqh1bL9nH6vs/IbX/+YhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0uSI67V; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6eeff1fdfso341269785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734378578; x=1734983378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LNy2uYAQLvX7Yum35lwl6aWibHIIBXzf8t75pVbhXI=;
        b=G0uSI67Vbf4lTWeotWefQXMYjNmrRlp8VH4GJ1Mrr4dS/tz81QNga5lSk+zTG3HKbD
         +QKk6Ga2Ak0yakh3Z/8FZjwdKlHbY+63cBS6WtW/dk7fZj+QvSDVJxNmtI/WPrl0Rm8M
         uMhCuBGnXOAMeT6Wp9BlI7BNXyvJMjGB6Mn7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378578; x=1734983378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/LNy2uYAQLvX7Yum35lwl6aWibHIIBXzf8t75pVbhXI=;
        b=JWzfL/18BcQH7zHYgf0YLaj+h+lRZIvBdah2ZgN5nY9n9qnJxtXuDYSqve5UPQqNZY
         p9olaKOt55O8yosu7tej2qtypbnWNQKUlTTn85SSdfeimV9v6a2nGEVpF7I0CgEX+8Ht
         DcqTv/ikGqoemdDAEwZc1cxd7lObAySfzfREAfxvYXPDQsJw/kWEVILcG2luhS+iqKIw
         HkeRkFOCZLurEIB4qkXElQs6EvsFap9QX59jb+BMb+RCxGCROkXUBt5UhUsXSRlqb8ev
         x5LS0xWk9I9+tLp30QBBt7RUPl4Ff89KcxWgGuoFKgxrkYfeImgAW7HEI/zUqhiUt1th
         JKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXrPbjaeut35SzCoyhsLco0nwNUDihuowswBGCl6QMZ66EFuV4Sa2ev6/0TUZS1lN7lh/BfYl73ue1YHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXw2XAxfINNDCiJHVLxxSLfA45mfnjAo6xPyuBbzCBRPAn1DZ
	9aUXu3kt8/ih4ky7vi1UD8yB8tqpv+4yQVm3NTwHYyJsBMdxZJDV7shXtgo/UYy6gPRpLMpkMaB
	C4m1s9IY8TBHpBS8mTuigi9UfhAUsomGzqzHZ
X-Gm-Gg: ASbGncs4Dapj9biMAbRUvyOSnBM7KBbLMDP6yX9cS7/95nXm3LQsoi/bs2odjP5UABD
	LwuTbwMxDwQgi+xYCw3LFUSF/PHynJV9RHPTTcz4Xq6+IS821iiKlJOtVAFcPlAyiuw==
X-Google-Smtp-Source: AGHT+IGohp0hGmz6f/D7NUUpgkTIS1kh1HZGfm7WOqi0KOo6p1jF3/g/6k7Mgcwm72Mk1bPLFZ1ljnrq+DyXufRmGLw=
X-Received: by 2002:a05:620a:370c:b0:7b6:7863:cbc4 with SMTP id
 af79cd13be357-7b6fbee76e4mr1530415685a.18.1734378578189; Mon, 16 Dec 2024
 11:49:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 14:49:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANFp7mV75SpTAyh=A4kZA2=NWi7+ry0+W+a5kpcjLrPwyhJ8UQ@mail.gmail.com>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
 <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
 <2bfe74d6a29ca13a7f89f116a2f0c6be.sboyd@kernel.org> <CANFp7mV75SpTAyh=A4kZA2=NWi7+ry0+W+a5kpcjLrPwyhJ8UQ@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 14:49:37 -0500
Message-ID: <CAE-0n50jvejyc1HO62mDBCCoV8eT3uL9sgu2B=ZeSHKxv=w+SA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] platform/chrome: cros_ec_typec: Displayport support
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: chrome-platform@lists.linux.dev, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, tzungbi@kernel.org, akuchynski@google.com, 
	pmalani@chromium.org, jthies@google.com, dmitry.baryshkov@linaro.org, 
	badhri@google.com, rdbabiera@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Abhishek Pandit-Subedi (2024-12-13 10:33:19)
> On Wed, Dec 11, 2024 at 1:58=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:16)
> > > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/p=
latform/chrome/cros_typec_altmode.c
> > > new file mode 100644
> > > index 000000000000..bb7c7ad2ff6e
> > > --- /dev/null
> > > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > > @@ -0,0 +1,281 @@
[...]
> > > +struct typec_altmode *
> > > +cros_typec_register_displayport(struct cros_typec_port *port,
> > > +                               struct typec_altmode_desc *desc,
> > > +                               bool ap_mode_entry)
> > > +{
> > > +       struct typec_altmode *alt;
> > > +       struct cros_typec_altmode_data *data;
> > > +
> > > +       alt =3D typec_port_register_altmode(port->port, desc);
> > > +       if (IS_ERR(alt))
> > > +               return alt;
> > > +
> > > +       data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> > > +       if (!data) {
> > > +               typec_unregister_altmode(alt);
> > > +               return ERR_PTR(-ENOMEM);
> > > +       }
> > > +
> > > +       INIT_WORK(&data->work, cros_typec_altmode_work);
> > > +       mutex_init(&data->lock);
> > > +       data->alt =3D alt;
> > > +       data->port =3D port;
> > > +       data->ap_mode_entry =3D ap_mode_entry;
> > > +       data->sid =3D desc->svid;
> > > +       data->mode =3D desc->mode;
> > > +
> > > +       typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> > > +       typec_altmode_set_drvdata(alt, data);
> >
> > 'data' is of type struct cros_typec_altmode_data here
> This should have been allocated as cros_typec_dp_data. Missed during a
> previous refactor that changed the type from a union to this format.

It would be good to have the cros_typec_altmode_data member be somewhere
besides the first member of cros_typec_dp_data so that this fails faster
when stashing the pointer into the drvdata and treating it as the wrong
type on the other side.

