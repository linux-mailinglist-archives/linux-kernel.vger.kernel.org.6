Return-Path: <linux-kernel+bounces-559352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01888A5F295
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B2F7A9448
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A52661BE;
	Thu, 13 Mar 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCmPih5P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D211F1518
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865986; cv=none; b=CF7R3v4Km9aZ54w0DvD5fO7iw1KRa5d+raEHqrG5/CiTGWnEeblPiohKBPDlJ/L9oQvKzxv9vcF2w0pSfRWFOKFpufX/ehd9NKtegw1SDT9RF0J+uZ0Iat6nAFmtQJCar+5fJ/ZlLKooqvgSS+w+d3LICXyhcARB7MMwy0b5W2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865986; c=relaxed/simple;
	bh=Yl8GqR3ard3wZBk0XTo9J2JcoNLtTNwMcgfq7YUjFto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GdsufvrIZYcLiY6eQQTkYt4ZRiA+aJLvTvwJX4SuyKZKxV0LtWU/oB84QTXqsWoWN1PjoTdEL2legshevueQFvfZWTKitKfPjdqzWjmfQhiIP0/aTWCvT6D+DUrmvQEQYfZ016vnT2vNlVnJ5WYU+NHMiMPtN9RA0gDCBDv1dDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCmPih5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741865982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBKFPkywWLlyqcwAktL0j35GbM9v3hWST4pP/Wm7RKk=;
	b=bCmPih5PDS7/yfnzegVcGnzzgXDV0OZpFzBv03TTKhsG1wo0B/BsH1v1Zu3EnCpXD2pUTH
	OliGvoQuVEmc0A/BHwe7qxpP3M+EYbzKi/WBN1q2dXoZE+z/jor2Q0o0LL9mnGNSpEQC4b
	KX/FWf2wwKlQqhud6sGn1U9EU6XUquk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-G020APXLNb6moDUCvEK7AQ-1; Thu, 13 Mar 2025 07:39:41 -0400
X-MC-Unique: G020APXLNb6moDUCvEK7AQ-1
X-Mimecast-MFC-AGG-ID: G020APXLNb6moDUCvEK7AQ_1741865980
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso4249085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865980; x=1742470780;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBKFPkywWLlyqcwAktL0j35GbM9v3hWST4pP/Wm7RKk=;
        b=hcxtHyW5cMLQvzlUmr9qGxvQV2AmVFLDrrZfaFoDPebuvHw+ayuP46qvgVzxCPZfUB
         IZhcQ0lteKfkdONFm3G8kJN27b8v2gK2zMlgl/mNm4hd75vTYj/0oDaIL700lOrXotWY
         CvPNya0dZkpdHpfTVQQq3b2H9HpxHKiBhpEEC7a0Kk8UfCC49S9T/Bt+BUM2pAGkXEUg
         wp65FNY0ZMlXBV1nVjeL2fhLLxAI4A0ni5Jt9sbEzyt7dSbpj1N2htcnJ72oMLN9wu8n
         1tWn73k4XO2cL8/F5PocbNfPNezfXAzGlaG4/mbjFEi/ta8nr3uAzi/7FJ92sBvkSpac
         BGgA==
X-Forwarded-Encrypted: i=1; AJvYcCVnXpqt2zHS9g/N5limGq/0w6yJz06kTf7d7s0KsDYbAvk8CL6ZWBz/aG2B2Up61ozesnEiIG/tukS+YHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzl8IVSX1SO5Jf0Ny007kl2boOWgtkbOkh4mqH0DOWdQHNWyWm
	I3/laE29tyGnM1hPD/KI4+mcDAV894hzrMMsRzP8TkMROeU/bacrSB/JUHbmJD5tC97Rf83yRDf
	JyjFHL2165hXfhQYx8SN5/kZ2V+/pz6oH6wd7D0OtZDzSsGs0x0x+535y4BqxJw==
X-Gm-Gg: ASbGncuZKoZu5Yjg0ssXa0J4m/fGsefAIOJYeLkSMKgltzY14M5BiRBfv+UvjvfOj10
	qmybZ/bi/iDbMMaCtnJzNuWcmVkBi0mXgNjXfxvLLehDci6fyu7f0tybvbsKkGisP1XX0hXER3F
	2qB9nUIT72KYsa/53KQoZxaKYF8TbT5pGvOSdaETA4cOtIjEvq87t9bvISw3cUFklnebd0dQLwZ
	mE8Trq4MGjkMYKYUsjZDV3jF1aS6dyzlse5t9OGKSY7kuHoPin7qLMMNWsfPCdWmALrwTLBCUOh
	OQFGShyBN+yLWBnMpLJfVu8bcnAlbF1RZu96NRpB6A==
X-Received: by 2002:a05:600c:4ec9:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43cfe154363mr125796565e9.6.1741865980199;
        Thu, 13 Mar 2025 04:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxTTxy7wV75Pg+Ic27UIp9nAkCa7Y0291ZqkbOwBvzG41JZxvnc2mwuuU4wnuQFYwkDO5RQ==
X-Received: by 2002:a05:600c:4ec9:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43cfe154363mr125796415e9.6.1741865979832;
        Thu, 13 Mar 2025 04:39:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b22f4sm18014315e9.1.2025.03.13.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:39:39 -0700 (PDT)
Message-ID: <1bf27354248772fa7b8d15fdb305353f6e212966.camel@redhat.com>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Petr
 Mladek	 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Thu, 13 Mar 2025 12:39:36 +0100
In-Reply-To: <20250313081659.N-X57_b_@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
	 <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>
	 <20250313081659.N-X57_b_@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Thu, 2025-03-13 at 09:16 +0100, Nam Cao wrote:
> Hi Gabriele,
>=20
> On Wed, Mar 12, 2025 at 08:58:56AM +0100, Gabriele Monaco wrote:
> > On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> > > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > > index 510c88bfabd4..c55d45544a16 100644
> > > --- a/include/rv/da_monitor.h
> > > +++ b/include/rv/da_monitor.h
> > > @@ -16,58 +16,11 @@
> > > =C2=A0#include <linux/bug.h>
> > > =C2=A0#include <linux/sched.h>
> > > =C2=A0
> > > -#ifdef CONFIG_RV_REACTORS
> > > -
> > > -#define DECLARE_RV_REACTING_HELPERS(name,
> > > type)							\
> > > -static char
> > > REACT_MSG_##name[1024];					=09
> > > 		\
> > > -
> > > 							=09
> > > 				\
> > > -static inline char *format_react_msg_##name(type curr_state,
> > > type
> > > event)			\
> > > -
> > > {							=09
> > > 				\
> > > -	snprintf(REACT_MSG_##name,
> > > 1024,							\
> > > -		 "rv: monitor %s does not allow event %s on
> > > state
> > > %s\n",			\
> > > -	=09
> > > #name,							=09
> > > 		\
> > > -	=09
> > > model_get_event_name_##name(event),			=09
> > > 		\
> > > -	=09
> > > model_get_state_name_##name(curr_state));		=09
> > > 		\
> > > -	return
> > > REACT_MSG_##name;					=09
> > > 		\
> > > -
> > > }							=09
> > > 				\
> > > -
> > > 							=09
> > > 				\
> > > -static void cond_react_##name(char
> > > *msg)							\
> > > -
> > > {							=09
> > > 				\
> > > -	if
> > > (rv_##name.react)					=09
> > > 			\
> > > -
> > > 		rv_##name.react(msg);			=09
> > > 				\
> > > -
> > > }							=09
> > > 				\
> > > -
> > > 							=09
> > > 				\
> > > -static bool
> > > rv_reacting_on_##name(void)				=09
> > > 			\
> > > -
> > > {							=09
> > > 				\
> > > -	return
> > > rv_reacting_on();					=09
> > > 		\
> > > -}
> > > -
> > > -#else /* CONFIG_RV_REACTOR */
> > > -
> > > -#define DECLARE_RV_REACTING_HELPERS(name,
> > > type)							\
> > > -static inline char *format_react_msg_##name(type curr_state,
> > > type
> > > event)			\
> > > -
> > > {							=09
> > > 				\
> > > -	return
> > > NULL;							=09
> > > 		\
> > > -
> > > }							=09
> > > 				\
> > > -
> > > 							=09
> > > 				\
> > > -static void cond_react_##name(char
> > > *msg)							\
> > > -
> > > {							=09
> > > 				\
> > > -
> > > 	return;					=09
> > > 					\
> > > -
> > > }							=09
> > > 				\
> > > -
> > > 							=09
> > > 				\
> > > -static bool
> > > rv_reacting_on_##name(void)				=09
> > > 			\
> > > -
> > > {							=09
> > > 				\
> > > -	return
> > > 0;							=09
> > > 		\
> > > -}
> > > -#endif
> > > -
> >=20
> > I don't think you need to remove those helper functions, why not
> > just
> > having format_react_msg_ prepare the arguments for react?
>=20
> I'm not sure what you mean. Making format_react_msg_* a macro that is
> preprocessed into arguments? Then make cond_react_*() a variadic
> function,
> so that we can "pass" format_react_msg_* to it?
>=20
> Going that way would also need a vreact() variant, as cond_react_*()
> cannot
> pass on the variadic arguments to react().
>=20
> Instead, is it cleaner to do the below?

Hi Nam,

you're right, I got a bit confused, all I meant was to find a way not
to repeat the arguments for implicit and per-task monitors.
What you propose seems perfect to me.

Also for the sake of simplifying things, a bit like you started, we
could have the reacting_on() check inside cond_react and drop the per-
monitor function. I believe the initial idea was to have a reacting_on
toggle for each monitor but since it isn't the case, we don't really
need it.

Thanks,
Gabriele

>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 510c88bfabd4..e185ebf894a4 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -19,22 +19,14 @@
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0
> =C2=A0#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static char
> REACT_MSG_##name[1024];								\
> -
> 												\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)			\
> -
> {												\
> -	snprintf(REACT_MSG_##name,
> 1024,							\
> -		 "rv: monitor %s does not allow event %s on state
> %s\n",			\
> -	=09
> #name,										\
> -	=09
> model_get_event_name_##name(event),						\
> -	=09
> model_get_state_name_##name(curr_state));					\
> -	return
> REACT_MSG_##name;								\
> -
> }												\
> -
> 												\
> -static void cond_react_##name(char
> *msg)							\
> +static void cond_react_##name(type curr_state, type
> event)					\
> =C2=A0{							=09
> 				\
> -	if
> (rv_##name.react)									\
> -
> 		rv_##name.react(msg);								\
> +	if
> (!rv_##name.react)									\
> +		return;				=09
> 					\
> +	rv_##name.react("rv: monitor %s does not allow event %s on
> state %s\n",			\
> +			#name,				=09
> 				\
> +			model_get_event_name_##name(event),=09
> 				\
> +			model_get_state_name_##name(curr_state));
> 				\
> =C2=A0}							=09
> 				\
> =C2=A0							=09
> 				\
> =C2=A0static bool
> rv_reacting_on_##name(void)								\
> @@ -45,12 +37,7 @@ static bool
> rv_reacting_on_##name(void)								\
> =C2=A0#else /* CONFIG_RV_REACTOR */
> =C2=A0
> =C2=A0#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)			\
> -
> {												\
> -	return
> NULL;										\
> -
> }												\
> -
> 												\
> -static void cond_react_##name(char
> *msg)							\
> +static void cond_react_##name(type curr_state, type
> event)					\
> =C2=A0{							=09
> 				\
> =C2=A0	return;					=09
> 					\
> =C2=A0}							=09
> 				\
> @@ -171,7 +158,7 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)				\
> =C2=A0	}						=09
> 				\
> =C2=A0							=09
> 				\
> =C2=A0	if
> (rv_reacting_on_##name())								\
> -
> 		cond_react_##name(format_react_msg_##name(curr_state, event));			\
> +		cond_react_##name(curr_state,
> event);						\
> =C2=A0							=09
> 				\
> =C2=A0	trace_error_##name(model_get_state_name_##name(curr_state),
> 				\
> =C2=A0			=C2=A0=C2=A0
> model_get_event_name_##name(event));					\
> @@ -203,7 +190,7 @@ static inline bool da_event_##name(struct
> da_monitor *da_mon, struct task_struct
> =C2=A0	}						=09
> 				\
> =C2=A0							=09
> 				\
> =C2=A0	if
> (rv_reacting_on_##name())								\
> -
> 		cond_react_##name(format_react_msg_##name(curr_state, event));			\
> +		cond_react_##name(curr_state,
> event);						\
> =C2=A0							=09
> 				\
> =C2=A0	trace_error_##name(tsk-
> >pid,								\
> =C2=A0			=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),				\
>=20
> Best regards,
> Nam
>=20


