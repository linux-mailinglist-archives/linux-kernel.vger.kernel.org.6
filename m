Return-Path: <linux-kernel+bounces-434652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469729E6969
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC415281BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801F1DF748;
	Fri,  6 Dec 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LprtvXoG"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBE1B4122
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475345; cv=none; b=aXjtNLu36a/S1DHQTxVLiyXpdM3+ZBtb/T7js3F/61MWtnazjTMeG48To5RWGG9ro9xqRTfxpAl7hsDG57PGTT6pa6csFOKUQhtbUDWUHYDkklRyWZEdq8AuhYz8lItBgA2bKuX6RJBw1RkfpK+TGednXycN3+cx9tU0QaPTdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475345; c=relaxed/simple;
	bh=K4VXv+Bl3TwM7KWxXQLUm6Ey2+mMwbatbCupddqxicI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beFAzwj2XjHRvhWzF0ge8oVuEdgfBv2oEP0OGlKXpL+nwLLYvnwksRMxVmA5y1QetmqjM+e21aVKeUbgJChNT2ju2EisEv72COuU6aV6rXRUGGwh4YycIaR5WxExMu3v/zT2CN7ScX8sc6hk/KiOPP5j/yLd3FjeTCdwpGn4JhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LprtvXoG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef7f8d4f30so13378327b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733475343; x=1734080143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB1lXFAba1EHLXEp5g/a09c/v/j02AjnIsWH8/a2o9U=;
        b=LprtvXoGYfLpcjZ5AshvQTTuP8ZR03rvDq8OoWiiyF8HumZt81sTMRXBcS/crbelzm
         9uVxaiU/6bPVSFN62iETu6LYNSA3TwV7Aww0J8ki59lL1Un9qWiKJ2DjlQDak1FdDwVf
         OneAWqMjnS0rPpeY/iy6OA59WSLIr5ef+m3grkMag3w0U/5LZP9eCjjaKXjbE1ECHOOs
         n+zwOkaW9C7eNUtYP1XlqGfUyr5NFlZtPMe3Usa4GQ79kJIAai10pib90NYzMcJpl+Ki
         PQ5GwjpXt0EQ8mzuW/Mq4Ts6Vwa8i687N5VPi7eVLUiAaJkhTSi8pHF9OWY0WDMoAh5N
         Sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475343; x=1734080143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB1lXFAba1EHLXEp5g/a09c/v/j02AjnIsWH8/a2o9U=;
        b=aO64OSMovJer0rYFdihT4lda5rxfrMqPerxDEWVpblBJTKs/bGfDzzcLyJzhdCYVQx
         ErgZZK7DmXGWflzHG4Rw8Q1a9uXQNFWZk28FlJlSvbK+VK3z05k1/7zTJiMrGQukxQmB
         mgSXVTLLcpARVxSBMdJvBpOysggNNXOgVwoVWOxTMK6BGPcx8AWclzpQX55iOhc9UeND
         6dH9l5lG2YqJoT//42DJRX8qWBEeGhf1Zi22AxyKiCfTACvdamyJf9iJndERE2UswAIR
         tfcq/ILosLlyMRWw3mEpjO1/9ZWArzDpbYFRUbXjCESLj0gFMv6rFJJkasyQvSjmb52U
         M3iA==
X-Forwarded-Encrypted: i=1; AJvYcCXFsherF6LUTkIu2y+ylh249GJFWPLp5Tbtwh1g7gTV21NejwmPLZ/KkME78tlPHv5Ce0XwlPIVEyY/Q5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcmHx8JgSUAhLCV0erMimxrU4Uy7fpu5OgZalr65xLGcXUycx
	0pU9JVp0Y5/dospZQ2F8VZjDCZVsgcNh5JhqBMwzfcbYv8VXP6Y/6HsblOSmbGwG2MLJx4CsofN
	906r3sO/eu9iYFQXKceABdJ/qStwvYwKie1uy3QHDkCcojUcmtQ==
X-Gm-Gg: ASbGnct6SH0wqYTEebFO49777WnpCoXtsZFuOl7l+nN9U4XK2V/uv++3gr630BGfHEd
	0Rk1M/ySzICXpEzdPERf2nJJB+9XQvg==
X-Google-Smtp-Source: AGHT+IGtmvIG3QFiq5VWSdE96AkQy1GTIbz0u0OzgBoMZwxE/J9c+1zsJP6yOLKJsYTPPNmrB+CNwCy4+DFjJf8dokk=
X-Received: by 2002:a05:690c:46c3:b0:6ef:6f24:d092 with SMTP id
 00721157ae682-6efe3bf49f3mr26570807b3.1.1733475342821; Fri, 06 Dec 2024
 00:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204104514.1541964-1-dawidn@google.com> <Z1Jc4XC9z5lnYc4H@google.com>
In-Reply-To: <Z1Jc4XC9z5lnYc4H@google.com>
From: =?UTF-8?Q?Dawid_Nied=C5=BAwiecki?= <dawidn@google.com>
Date: Fri, 6 Dec 2024 09:55:31 +0100
Message-ID: <CAJ_BA_D0S1oFQiH2odVgfnd9dL76_t5Tzc_0n5B+fVis21+sAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: jump to RW before probing
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:09=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Wed, Dec 04, 2024 at 10:45:13AM +0000, Dawid Niedzwiecki wrote:
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform=
/chrome/cros_ec_proto.c
> [...]
> > +int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev)
> > +{
> [...]
> > +     for (int i =3D 0; i < RWSIG_CONTINUE_RETRIES; i++) {
> > +             ret =3D cros_ec_send_command(ec_dev, msg);
> > +
> > +             if (ret < 0) {
> > +                     error_count++;
> > +             } else if (msg->result =3D=3D EC_RES_INVALID_COMMAND) {
> > +                     /*
> > +                      * If EC_RES_INVALID_COMMAND is retured, it means=
 RWSIG
> > +                      * is not supported or EC is already in RW, so th=
ere is
> > +                      * nothing left to do.
> > +                      */
> > +                     break;
> > +             } else if (msg->result !=3D EC_RES_SUCCESS) {
> > +                     /* Unexpected command error. */
> > +                     ret =3D cros_ec_map_error(msg->result);
> > +                     break;
> > +             } else {
> > +                     /*
> > +                      * The EC_CMD_RWSIG_ACTION succeed. Send the comm=
and
> > +                      * more times, to make sure EC is in RW. A follow=
ing
> > +                      * command can timeout, because EC may need some =
time to
> > +                      * initialize after jump to RW.
> > +                      */
> > +                     error_count =3D 0;
> > +             }
> > +
> > +             if (error_count >=3D RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
> > +                     break;
>
> Only if `ret < 0` makes the condition true.  How about move the statement=
 to
> where `error_count` increases to make the intent more obvious?  I.e.:
>     if (++error_count >=3D ...)

Good point. I'll change that.

