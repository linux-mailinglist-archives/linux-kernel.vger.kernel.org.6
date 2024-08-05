Return-Path: <linux-kernel+bounces-275477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D2948642
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F5F1F2399B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02C16F26D;
	Mon,  5 Aug 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJE6w0df"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B614A088;
	Mon,  5 Aug 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901174; cv=none; b=QyelnpEpN5nFR78zZGWHic/bN2t9uEFmBGhZSvgEcnsN1J2x2KJ2H00ooGAuFrVaos3jiGdc9USURnCA4UoYZHhcPxiNI3/+0wC7KnO/x2tJrruJYEqgdEmLqZmRc+sW0BQgaLbFyup+3eeMBy+0BgdplvnGtorIajFIUpbtCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901174; c=relaxed/simple;
	bh=2fCVAklTUF0kLHe/D2HsjL2l8dhsH3kZk+qLnmdKuoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvdBjB0+LAzeicAy2FJezbssamvB/0KXkcE8YkWNUt5mE75QcgBNuRLzT9B1vajMWILxXjmoR8uuhnGorxmtJYsP9Q01D/elkBOLzYlf5de9eZynOnj5Pb6xMLCZiqeBTuR4K8HpFmLqhdOSu2pTKoaeTcnim4pEVg/To1cjFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJE6w0df; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-369c609d0c7so12818f8f.3;
        Mon, 05 Aug 2024 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722901171; x=1723505971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRm7h848gM4LQoUntuzl0MVFQcLGKnAidDnJirtNqmI=;
        b=MJE6w0dfemZatKnFt2s+vsTWYKg6taK7DixdGXFXXK9XhRMdCnlYVd5Hn17CUcz3f1
         Fd4MgUzRNyA3EzLWW+txixOGgfmNQ0fe0zg/HDKbG1khDHcm4braAQLxso09arTXKZg7
         6tJXN26bx/G4TSbMozvlHiU5U2B/chp6OBeJP4OkR51IsXUY1EAjiYcPr6FzfeIYOOUc
         BHQCUUAuTWSgPMv2cwj2WlIHxVaZGc0JYRlQFwRHTNbi0Pi2Vv21DA/LQX2FZCgyEy8r
         cWesMA+Ocut9zUwG7OeA3Mw8gsi9TxRuYBG2xNUXa13uZ+oUMI1VXlSoAZB1yb1673Gc
         7gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901171; x=1723505971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRm7h848gM4LQoUntuzl0MVFQcLGKnAidDnJirtNqmI=;
        b=rN9TmrXeWowxzNOvE/hZO24o/f57tPDtoXAOGfi7k87cpxU8TMm4KFN/nQ5+FUk4l+
         nACKL+vVyRoHnn5wXnvd6zdH2cylvwC+ij5Y+718RbkZbtQIk52XJFcwnUAPMFkdH7gN
         WZRmVHw6t8fhJEanLEfcl2G6GL64yvgPKf7Uy5hEAMeX92YqHMLiAK4lIZzc2CUcvkkw
         VZInezdmAEjdb7O+7bu6db2c3Fl6lABWu3Wovwnk+TWeMnWasthCU22guEunIbmAQNFW
         Q9y0dp+ecSPHR6WYdh01EAK1ZywQY4pwcFUaXeYI1uAJN324jpZCZ8sCezdqflUQ6yS/
         28yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhoRjjxEgUddslnCUQRAUoIy+B6BuyzsdDQDFZZ6YDuubAfDF4NMCJghLIrnDJPn4lpNCfgHkRZIpqG12RM0v/Kvd9KTYjHBa9PoXNjbXVTof2FrNGQfzB8dtHZyh+QnTjeokOH9tv
X-Gm-Message-State: AOJu0YxcqSKbPwtU/RUuqQbnQlO34+eSMt3rZ/O54RhNXrXGYOKkFVt7
	gxaNutMFreY8gBHE9M17ZSCPBQ0gmIk1ecLHE2PzodK9vPN6Uujofecu7obN0P0ikD9Y67ZsfEt
	tJBI25we4OTmH+yXf7Wwsm9ltktA=
X-Google-Smtp-Source: AGHT+IE+PC+LoFKU9Uz/vKjYS+JSm0mjbNEO6z87Y//rhb0qlhTESgxmQ3wsq07Ia0e8gX5p7UXy7OdDUN740N52i8A=
X-Received: by 2002:adf:f90d:0:b0:369:b842:5065 with SMTP id
 ffacd0b85a97d-36bbc1a5f54mr10129366f8f.41.1722901170648; Mon, 05 Aug 2024
 16:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805000639.619232-2-crwulff@gmail.com> <ZrBJaW_EwNf_T_WZ@casper.infradead.org>
In-Reply-To: <ZrBJaW_EwNf_T_WZ@casper.infradead.org>
From: Chris Wulff <crwulff@gmail.com>
Date: Mon, 5 Aug 2024 19:39:19 -0400
Message-ID: <CAB0kiBLrZ+t8voXNGkDudG+vy4i3pOP77Pn9ytrprii6OPXjFQ@mail.gmail.com>
Subject: Re: [PATCH v4] usb: gadget: f_fs: add capability for dfu run-time descriptor
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Cercueil <paul@crapouillou.net>, 
	Christian Brauner <brauner@kernel.org>, Eric Farman <farman@linux.ibm.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Sands <david.sands@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 11:39=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Aug 04, 2024 at 08:06:40PM -0400, crwulff@gmail.com wrote:
> > diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.=
h
> > index 44d73ba8788d..91f0f7e214a5 100644
> > --- a/include/uapi/linux/usb/ch9.h
> > +++ b/include/uapi/linux/usb/ch9.h
> > @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
> >  #define USB_DT_DEVICE_CAPABILITY     0x10
> >  #define USB_DT_WIRELESS_ENDPOINT_COMP        0x11
> >  #define USB_DT_WIRE_ADAPTER          0x21
> > +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> > +#define USB_DT_DFU_FUNCTIONAL                0x21
>
> This is the only place in the entire patch where you explain what "DFU"
> means.  Is this really such a well-known acronym that it doesn't need to
> be in the documentation or the commit message?

Yeah, it would probably be good to add that to the documentation. I'll
add that info.

(It stands for "Device Firmware Upgrade")

  -- Chris Wulff

