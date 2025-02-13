Return-Path: <linux-kernel+bounces-512389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F0A338A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0944A7A28B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962422080D6;
	Thu, 13 Feb 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKUCldKf"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA5205E06
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431034; cv=none; b=choYbS3diLyiwFPXwIZ84HgB9rsbC/meazUpveiFOZ0eBSVSkrsm8guwKI6gQxURwayILAb9tAG56zPwMfLLzDX6BFMmLAEdseudK7vhYNVYlNyx2/fm+PHevZtICZcRNYZasgStYGnn4FidFjPBWWxqB2x6WKe9BZTcqrVXwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431034; c=relaxed/simple;
	bh=XwVMXNQ761j3J7Ptn4ee+kWiWQc+4AgbYEzScpJOJFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/0hnIZLhTx//bZitD1bKs7xNVradZNcwhEUAZvV1TdB8hMCJLKkGVKzn75LQS4neXnIW5+k2M/F7dtdj2edALmpNySI1qSaIbzK8f3OCsf1a16jqLESXpkK7SA8PI0q4UfcG3gbunGutvPsnEKgjK50xA590ln755SZ1xCCmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKUCldKf; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b89395a3efso318813fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739431032; x=1740035832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAPzHDLMa8F4I+uGf+X/tuBXjfEKEnfqltbhxTQMiCY=;
        b=pKUCldKfzYzCQNftwC8WE7i8y3OusWFZkjrH86JyEJyFMzMnP7mnx5FHb2VSrqdvo4
         lpYAyDOBZgkH+mSnZYvulxenYcJ5noxEmLAzCW9niPIVB9LJRVixTHWauRYTf2krubus
         3ZNmZwOyUNN/tINzIpd7h2Kk8zZUrOh7I8hUy11ArGs0SEF3ABkyDigMHEXknmwL/O1i
         O9S9Ilwsmu8lC69XPZ0AJJk0svk7kakJdV0At5bc1z1JmvHgs+9NfvVvoZ8JlzJs7Mhe
         h/JaKgFzLIsOzibxA2yvYr59MTdEQ0Q+Ylx/KFJzTdD1AlIR2D/N8EYcYhl1ZMUTPDuN
         mAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431032; x=1740035832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAPzHDLMa8F4I+uGf+X/tuBXjfEKEnfqltbhxTQMiCY=;
        b=unxv2VMqwqgjwTj5b7zT2ltxG9+URNTMEhY5fmXkRVEjaMWXxGewuY7F3IWosktUM7
         l3aLdBNGrHxWhCM6OohjOQCNsT4VmUJmeo3yL/zKU8odMqRKra1SjduJp/Xy0/IXPyfr
         dU9x2P64N375CTmzrs6RVXoc9ZGEMQJNEQ3hxOn2YJKt4RxBzRUbofvYE01e08PG3Dy3
         gk5tFGot3Za/iU27R7ZBr0L79WFHKrEinSbJzDi8ULfbHKW3QzwoZFvjuH98pm1nf6tx
         0lZYdTU+mEPYczk4F2NYtjFrjpJyHxk6DrN3+CbLZarv2iUBOVB1gQHTdke4yVNw61Qv
         RfWg==
X-Forwarded-Encrypted: i=1; AJvYcCWlJ4t4oSs3ZD92qi4wsGPNYjxof0ysacoOcghQWUtIr173dHcv7r0bA4S7vi0iTXN99Mdfn+OchK06lCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgxMt8bs5FBuZZuAVzOkcO8SlGWwQPtU30k+GLH/coPZ2oDVI
	aStYtyzg8eI2ATGhQvszbu+G1isnb0VXZoFzbhBd1QvfljSCx5Du+SD6Tt575fQCXDC2VGD7jVK
	UMqZnMoB+uAmgliCk1bK/UzBQc7S8/5sJAk0R
X-Gm-Gg: ASbGncujeJTZP5+j5EI8bT/XdW2B5UQZn7e+Uf6LabHNBVWF2yaiDX8XQOruzVDDMe8
	2PQTdPjsjYZOW2hiwwQ0Uss01ULEL1T6PPWp65XmSX7ZLZzgMEpb5obEBOFA186I6sSKeM35wqF
	y9IEXP/BUFF3jLAXtkxZf/tb4P0S0m8g==
X-Google-Smtp-Source: AGHT+IEfsRGc6DLQY4CQesdImaEpBlwTV0xIah205sPo/thcjlRBTIl4u2FV25/hHf9zrYLZB0A6O/UXUSdB+3lpew8=
X-Received: by 2002:a05:6870:7ecb:b0:296:fff8:817 with SMTP id
 586e51a60fabf-2b8d682f1e6mr3912622fac.35.1739431032122; Wed, 12 Feb 2025
 23:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209071752.69530-1-joswang1221@gmail.com> <5d504702-270f-4227-afd6-a41814c905e3@google.com>
 <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com> <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
In-Reply-To: <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 12 Feb 2025 23:16:35 -0800
X-Gm-Features: AWEUYZmRfdK_T6BH_zrmkDkJWGSMnlIR49ILGN6X5bdP8CDQPfCyq0ocxuORgqU
Message-ID: <CAPTae5J5WCD6JmEE2tsgfJDzW9FRusiTXreTdY79MBs4AL6ZHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap
 enters ERROR_RECOVERY
To: Jos Wang <joswang1221@gmail.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Jos Wang <joswang1221@gmail.com> wr=
ote:
>
> On Tue, Feb 11, 2025 at 7:51=E2=80=AFAM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 3:02=E2=80=AFPM Amit Sunil Dhamne <amitsd@googl=
e.com> wrote:
> > >
> > >
> > > On 2/8/25 11:17 PM, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > nit: From https://elixir.bootlin.com/linux/v6.13.1/source/Documentation=
/process/submitting-patches.rst#L619
> >
> >   - A ``from`` line specifying the patch author, followed by an empty
> >     line (only needed if the person sending the patch is not the author=
).
> >
> > Given that you are the author, wondering why do you have an explicit "F=
rom:" ?
> >
> Hello, thank you for your help in reviewing the code.
> My company email address is joswang@lenovo.com, and my personal gmail
> email address is joswang1221@gmail.com, which is used to send patches.
> Do you suggest deleting the "From:" line?
> I am considering deleting the "From:" line, whether the author and
> Signed-off-by in the patch need to be changed to
> "joswang1221@gmail.com".

Yes, changing signed-off to joswang1221@gmail.com will remove the need
for "From:".
Go ahead with it if it makes sense on your side.



> > > >
> > > > As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffT=
imer is
> >
> > nit: https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/proc=
ess/submitting-patches.rst#L619
> >
> >  - The body of the explanation, line wrapped at 75 columns, which will
> >     be copied to the permanent changelog to describe this patch.
> >
> "As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffTimer =
is"
> This sentence doesn=E2=80=99t exceed 75 chars, right?

Apparently, It actually needs to be wrapped around 75 columns, not too
early either.

Thanks,
Badhri

> >
> > > > used by the Policy Engine in Dual-Role Power device that is current=
ly
> > > > acting as a Sink to timeout on a PS_RDY Message during a Power Role
> > > > Swap sequence. This condition leads to a Hard Reset for USB Type-A =
and
> > > > Type-B Plugs and Error Recovery for Type-C plugs and return to USB
> > > > Default Operation.
> > > >
> > > > Therefore, after PSSourceOffTimer timeout, the tcpm state machine s=
hould
> > > > switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can al=
so solve
> > > > the test items in the USB power delivery compliance test:
> > > > TEST.PD.PROT.SNK.12 PR_Swap =E2=80=93 PSSourceOffTimer Timeout
> >
> > Thanks for fixing this !
> >
> > > >
> > > > [1] https://usb.org/document-library/usb-power-delivery-compliance-=
test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip
> > > >
> > > > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm=
)")
> > > > Cc: stable@vger.kernel.org
> > > >
> > nit: Empty line not needed here.
> >
> Modifications for the next version
>
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > >
> > > Tested-by: Amit Sunil Dhamne <amitsd@google.com>
> >
> >
> > >
> > >
> > > Regards,
> > >
> > > Amit
> > >
> > > > ---
> > > >   drivers/usb/typec/tcpm/tcpm.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm=
/tcpm.c
> > > > index 47be450d2be3..6bf1a22c785a 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > > @@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_por=
t *port)
> > > >               tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PW=
R_MODE_USB,
> > > >                                                      port->pps_data=
.active, 0);
> > > >               tcpm_set_charge(port, false);
> > > > -             tcpm_set_state(port, hard_reset_state(port),
> > > > -                            port->timings.ps_src_off_time);
> > > > +             tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps=
_src_off_time);
> > > >               break;
> > > >       case PR_SWAP_SNK_SRC_SOURCE_ON:
> > > >               tcpm_enable_auto_vbus_discharge(port, true);

