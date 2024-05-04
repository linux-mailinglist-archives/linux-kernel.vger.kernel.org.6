Return-Path: <linux-kernel+bounces-168553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B5D8BBA16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58A4282D9C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D91171C;
	Sat,  4 May 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3d/KUqr"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09C1CD16
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714811440; cv=none; b=fm8WANM7vJdkKt1r8P8KBJDAL/mX/2F0Tk/wRBA4s64N4Itvfm9rjcHHzRcWh6inDGd1mrVB411i/SYN88vcVUtMReaMawzS3mMVoo7qvLMuy4WCAUgmf3pOfaOLNeVFaYkBsFyznOAWfJJgFrxybN8bJPkIDIKsDI6B5RKwJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714811440; c=relaxed/simple;
	bh=QlqayoLSETnrMZTkG+pD6MJRQVAmQiZIQF2Dsi7cGFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA6FyiDH79k55U+uKpXOzmwo3UyijA96RzmDnDKGk812PP4lVUzBZRdDAPMLxXwsaQ2r+WaHoSiAYLlDaHPAu/FnrUOzgXd2sVbgEdb7+ix82eiH6NL8DhoOvC3i7O0gzsgJF/4HAJvs9gdwrnCgAJQ8SHvWvCBGFxEjwHqgy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3d/KUqr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-436ed871225so123531cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714811437; x=1715416237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oJQpDXIze0zw5t34tsxHgSF2mpOTPkFaVAJM4cFI5Q=;
        b=g3d/KUqrItZeYk/iAlE6ueYRHCqfSowOBIx1CIJsjsMDLTaNcKHQ51y+hYCFDXZLpQ
         amPH62ktXLttn1Jg5v8IcPXgqRdPhSYMTW1vIQo3ELKllHYW0LyzIoa0cbS/EmIDv81Z
         jXIp0ZxreXYTxzy9w61euHW4Az6UHJqXSx4FRicY5sFG9PgtBczQxjJGBExvSHuvdwGL
         DzcRMC15mpKtS8R6Y/7+7M5G/7KzDmWM8NhlxUupgwqZitEMU+hRPoa4XYPr5wKwI4uI
         rjkUapsp35N52+PIpIJGkWXPYk9/SNX0vHz6abvYWOTs1fWPu6VAgi2Krk3CnI2rUyJl
         EcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714811437; x=1715416237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oJQpDXIze0zw5t34tsxHgSF2mpOTPkFaVAJM4cFI5Q=;
        b=HIvlusMwN35Mbx7qZ7YygA77PJAdHyCxHuhgI0GM3JLQaktFsMXEZuXBHCST65Ud9x
         HJyenSBteHm9/vtO+VF6dppUUYsknGGQyVdz2EH1jPSw4+iIiqssA6jwOz8/5LgyGiz4
         ve3g6g04s1r/EuAQDqvInRCDjHThd4gernq94z34cZMc6pRi8E0daLkdXYxE6zf9p1nC
         ukT7cLzoktJq0/54LJbzAGMpYteEILsESFy//K6KxJavXzWaw00merqiUGi7CVjKL9Lm
         peyOjMolvJ0UjV3z9XQPfM8noWGLf0xMomcXyO1jph95MXTwVyrjksFwEmBFSIDCe+Wh
         Qx3w==
X-Forwarded-Encrypted: i=1; AJvYcCU8+NENjD0oqkSLujhb8RixWmFeJJXW78KADUDQMI3USkCyhjzcl0h4Az/MVDYS0wrEpzecCNTYHQCoTifldJnSOxZVRvkktBVqwyUB
X-Gm-Message-State: AOJu0YzKXkbiRRClkQ+16aS9WAVekPYGvsFq01MmT61pJWvptGxnNMMK
	Y9KqJBXg9TEhASXgTrk9xJ3qyG7AacjJdRIMDlVkQie5oAfjocaWlD28YOeRK7M8VsxwPlUnIA+
	4CvLe1AgLBBeZ1A/Ynk9g6ApXHwJ/FAbvhH/W
X-Google-Smtp-Source: AGHT+IEKKjNF94/tQcRb2QIUjeBMH5UEmKlUpCU1PDh2BsvSCTMhvo7GdNy52lx7nNlyriGSFJrLmGHjeDwZZHrcU4I=
X-Received: by 2002:a05:622a:413:b0:43a:b274:340e with SMTP id
 d75a77b69052e-43d030aea06mr1583531cf.8.1714811436897; Sat, 04 May 2024
 01:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-2-sboyd@kernel.org>
 <CABVgOSm_Qce1AZQjH8wE4t238hxLYTNswNf1AkEDbWtqDTK7Ow@mail.gmail.com> <15345b349077f57935e8f1d3d69f66f9.sboyd@kernel.org>
In-Reply-To: <15345b349077f57935e8f1d3d69f66f9.sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 4 May 2024 16:30:24 +0800
Message-ID: <CABVgOSm=h0gacXEAgag+9io1yXR5+8rHW_HzvnVTNuiAFBhOHA@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097eea106179ca65e"

--00000000000097eea106179ca65e
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 08:36, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2024-05-01 00:55:10)
> > On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
> > > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> > > index 2d8f756aab56..282befa17edf 100644
> > > --- a/Documentation/dev-tools/kunit/api/index.rst
> > > +++ b/Documentation/dev-tools/kunit/api/index.rst
> > > @@ -9,11 +9,15 @@ API Reference
> > >         test
> > >         resource
> > >         functionredirection
> > > +       of
> > >
> > >
> > >  This page documents the KUnit kernel testing API. It is divided into the
> > >  following sections:
> > >
> > > +Core KUnit API
> > > +==============
> > > +
> > >  Documentation/dev-tools/kunit/api/test.rst
> > >
> > >   - Documents all of the standard testing API
> > > @@ -25,3 +29,10 @@ Documentation/dev-tools/kunit/api/resource.rst
> > >  Documentation/dev-tools/kunit/api/functionredirection.rst
> > >
> > >   - Documents the KUnit Function Redirection API
> > > +
> > > +Driver KUnit API
> > > +================
> >
> > If we're adding a separate 'Driver' section here, it's probably
> > sensible to move the existing device/driver helper documentation here,
> > rather than leaving it in resource.rst as-is. I'm happy to do that in
> > a follow-up patch, though.
>
> To clarify, you're talking about "Managed Devices"? Looks like that can
> be a follow-up to split it into a new file and then put it here. If
> you're happy to do that then I'll leave it to you.
>
Yeah, this is "Managed Devices". I'll send out a follow-up patch to
the documentation once this has landed so we don't conflict.

> >
> > > +
> > > +Documentation/dev-tools/kunit/api/of.rst
> > > +
> > > + - Documents the KUnit device tree (OF) API
> > > diff --git a/Documentation/dev-tools/kunit/api/of.rst b/Documentation/dev-tools/kunit/api/of.rst
> > > new file mode 100644
> > > index 000000000000..8587591c3e78
> > > --- /dev/null
> > > +++ b/Documentation/dev-tools/kunit/api/of.rst
> > > @@ -0,0 +1,13 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +====================
> > > +Device Tree (OF) API
> > > +====================
> > > +
> > > +The KUnit device tree API is used to test device tree (of_*) dependent code.
> > > +
> > > +.. kernel-doc:: include/kunit/of.h
> > > +   :internal:
> > > +
> > > +.. kernel-doc:: drivers/of/of_kunit.c
> > > +   :export:
> > > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > > index 251d33532148..0dfd05079313 100644
> > > --- a/drivers/of/Makefile
> > > +++ b/drivers/of/Makefile
> > > @@ -19,6 +19,7 @@ obj-y += kexec.o
> > >  endif
> > >  endif
> > >
> > > +obj-$(CONFIG_KUNIT) += of_kunit.o
> >
> > I'm tempted to have this either live in lib/kunit, or be behind a
> > separate Kconfig option, particularly since this will end up as a
> > separate module, as-is.
>
> Is the idea to have a single module that has all the kunit "stuff" in it
> so we can just load one module and be done? Is there any discussion on
> the list I can read to see the argument for this?

I don't think there's been any specific discussion around making sure
KUnit lives in one module: this is just the first patch which would
make CONFIG_KUNIT build several separate ones.
Personally, I'd prefer to have the CONFIG_KUNIT option only build one
module itself, and otherwise keep the corresponding code in lib/kunit,
just so it's clearer what side effects enabling / disabling it has.

But ultimately, this really is just another side effect of the
discussion below about whether this is integrated as "part of KUnit",
in which case it can live in lib/kunit and be under CONFIG_KUNIT, or
if it's a part of of, in which case this is fine (though I'd rather it
be behind a CONFIG_OF_KUNIT_HELPERS or similar, personally).


> >
> > >  obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
> > >
> > >  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> > > diff --git a/drivers/of/of_kunit.c b/drivers/of/of_kunit.c
> > > new file mode 100644
> > > index 000000000000..f63527268a51
> > > --- /dev/null
> > > +++ b/drivers/of/of_kunit.c
> > > @@ -0,0 +1,99 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Test managed device tree APIs
> > > + */
> > > +
> > > +#include <linux/of.h>
> > > +#include <linux/of_fdt.h>
> > > +
> > > +#include <kunit/of.h>
> > > +#include <kunit/test.h>
> > > +#include <kunit/resource.h>
> > > +
> > > +static void of_overlay_fdt_apply_kunit_exit(void *ovcs_id)
> > > +{
> > > +       of_overlay_remove(ovcs_id);
> > > +}
> > > +
> > > +/**
> > > + * of_overlay_fdt_apply_kunit() - Test managed of_overlay_fdt_apply()
> > > + * @test: test context
> > > + * @overlay_fdt: device tree overlay to apply
> > > + * @overlay_fdt_size: size in bytes of @overlay_fdt
> > > + * @ovcs_id: identifier of overlay, used to remove the overlay
> > > + *
> > > + * Just like of_overlay_fdt_apply(), except the overlay is managed by the test
> > > + * case and is automatically removed with of_overlay_remove() after the test
> > > + * case concludes.
> > > + *
> > > + * Return: 0 on success, negative errno on failure
> > > + */
> > > +int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> > > +                              u32 overlay_fdt_size, int *ovcs_id)
> >
> > We're using kunit_ as a prefix for the device helpers (e.g.
> > kunit_device_register()), so it may make sense to do that here, too.
> > It's not as important as with the platform_device helpers, which are
> > very similar to the existing device ones, but if we want to treat
> > these as "part of KUnit which deals with of_overlays", rather than
> > "part of "of_overlay which deals with KUnit", this may fit better.
> >
> > Thoughts?
>
> I'm fine either way with the name. I recall that last time we put a
> kunit postfix to make it easier to tab complete or something like that.
>
> I find it hard to understand the distinction you're trying to make
> though. I guess you're saying the difference is what subsystem maintains
> the code, kunit or of. When they're simple wrappers it is easier to
> extract them out to lib/kunit and thus they can (should?) have the kunit
> prefix. Maybe that always holds true, because kunit wrappers are
> typically another API consumer, and if the API is exported either in a
> linux/ header or as an exported symbol it can be wrapped in lib/kunit
> easily. Did I follow correctly? When would of_overlay ever deal with
> KUnit?

Yeah, it's about what subsystem is maintaining the code, which impacts
a bit of the naming, and depends a bit on the intended use-case.

If these helpers are intended to test a particular subsystem, and are
of no use outside it, it seems clear that they should be a part of
that subsystem. For instance, the drm_kunit_helpers.
If they're exposing kunit-specific wrappers around core APIs, it makes
sense for them to be a part of KUnit. (The managed devices stuff, for
instance, as the device model is used by pretty much everything. It
also requires a KUnit-managed struct kunit_bus, which is hooked into
KUnit at a lower level, so needs to be a part of kunit.)

It gets more complicated for cases like of, where the helpers are both
used for testing of itself, and for testing drivers which rely on it.
So I think it could go either way. My gut instinct is that
platform_device is generic enough to be a part of KUnit (to match the
existing managed device stuff). For of_overlay, I could go either way,
and just leaned to having it be part of KUnit as that's a bit more
common, and it matches, e.g., the headers and documentation being
under include/kunit and dev-tools/kunit respectively.

> > > diff --git a/include/kunit/of.h b/include/kunit/of.h
> > > new file mode 100644
> > > index 000000000000..9981442ba578
> > > --- /dev/null
> > > +++ b/include/kunit/of.h
> > > @@ -0,0 +1,94 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _KUNIT_OF_H
> > > +#define _KUNIT_OF_H
> > > +
> > > +#include <kunit/test.h>
> > > +
> > > +struct device_node;
> > > +
> > > +#ifdef CONFIG_OF
> >
> > Do we also need to check for CONFIG_OF_OVERLAY here?
> >
> > Also, how useful is it to compile but skip tests without
> > CONFIG_OF{,_OVERLAY} enabled? The other option is a compile error,
> > which may make it more obvious that these are disabled if it's
> > unexpected.
> >
> > Thoughts?
>
> I've tried to make it so that tests skip if an option isn't enabled. I
> suppose the CONFIG_OF_OVERLAY check can be hoisted up here as well so
> that the skip isn't buried in lower levels.

Yeah, my feeling here is that if we're going to declare functions
which interact with of_overlay, we should have the 'skip' fallbacks
occur for either both CONFIG_OF and CONFIG_OF_OVERLAY here, or neither
(and require the test use its own #include guards). Having CONFIG_OF
checked here, and CONFIG_OF_OVERLAY checked elsewhere seems confusing
to me.

Cheers,
-- David

--00000000000097eea106179ca65e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIETN56TU+Zyv4/Xmc6NmhAeOjWx39QgDubV8PTXD5gbEMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwNDA4MzAzN1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQATQrkf
/KbZeMeWllE8hnVs5v4hUkMO5tZqJZ60AA62xWv8UqCpqX6+l0bOcovTrnCe2ovY+jLlSCxTpZaG
ZUX7Ftat5yVsfIh/tyUZiykqhQUwS39QpJUALn78lsO+JCwpOnpyMTx1VMLrUKoH9o6aDiRmIEl8
O6oXdxp7BTaLIiTCuIi36rZC2a7ktgFH3LvmBWv9z0PtXeRcHoA/LU4cq+Y8ppqtGmhs3RUSumqG
zqxunSUGYiWB7dPkb2+kAL/vv5nYLiL6QkInj3pQ3+BIk3VyIH9Ulf06Kmak6ilzYAG1G5mfTCYK
DhoggHKYjd/cxTDsPTHc0mEaawbgvylZ
--00000000000097eea106179ca65e--

