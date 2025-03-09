Return-Path: <linux-kernel+bounces-552949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67192A5815E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE817A5C8B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC717A30E;
	Sun,  9 Mar 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FLBWFHQl"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE118BB8E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741505738; cv=none; b=avyeevzy3miVSNU1s0+UR9I4ti1gyzf95xS6IekbJPnuAYN6w+g/8aXJh+cRZYqVWOnho+Wp4Rcx+IFjojx0XL7KujOU1SaIBbxetev1Xm6Dp/2mC2lc35E/rSpIkM+d3a7A7GvzDgIcrEinL3JTevc37TM9b5lhluWFURlTaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741505738; c=relaxed/simple;
	bh=ZK9Kt2VuuE5s9EiR1pqcyl/CVmyFvMsaowjzrSKPVWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpzQUHiQPBjX7wHPOwbc1jHlL8Widc/iebAJBNC0NTlQMBhOxiwWPSuSdLb5srHiEPPYFOGaAP5PB8pR/nSBMt03Y5h7AsWJ4BLOT0/pxQcXbclz6WRohhzqVgMKX4W7Qq6uvpJWItync10l2GQBPhwcUViIJC5K1Tvphp1Nzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FLBWFHQl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54998f865b8so1174038e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 23:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741505735; x=1742110535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6SMMG+k0y7azuA9zm15hM3QMAvlAakxhRXFdrBwZU0=;
        b=FLBWFHQloG40NJyBDt4l/wZtlr/BIkJOc5DO9gon5hvf8DVsrbkGxFbkaAtRS2Y4Z+
         fqOjXRXN4Y3YsTGXvNNRsHJbVke01OQTba8cDw8sB/P2DpOvo9V0WvwLf/pMZ40bMnjd
         ImtQa9ox+Kj69WXm2NWuZ65j4R8IshWM4A31U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741505735; x=1742110535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6SMMG+k0y7azuA9zm15hM3QMAvlAakxhRXFdrBwZU0=;
        b=v+QjG0TkboAHFI/HKLMkmst+0wdhTHxjXJHLId1FCMOcF19Y1S5VrNOsNvE6YEfglP
         1+bKkbC+l5KeU9FHO+MVAslCyRH7gRrv6MC86CQKvlqZ5qjto0RrzLM5KXZaeWJKM5Lv
         v7KlR0i1iivfYtNhTk5NucHsbp2l0tCQQ+yiK+LaFPQgQ/s68YmxTJ31AxCs0tj8QCW5
         nhGZNCf488vVJTiVKKIij6T/+z5TbNQGLRxChAzR4oW+cKARmNfvcL8FKHJXuMGmW0H+
         w1a62qfuoIyXIqXTW0qutfjlcLHHthHMhyf8kF4j8MqVpwzUo1N0LXdVjOZe8qrCwZ/t
         ClOw==
X-Forwarded-Encrypted: i=1; AJvYcCWgg2rp3mgxWpotJvGg4ek7KesQeFBACfhisAnVTY98ezLbiRlgAUN5HSfyQBfPLdvMO4c8gEwm+ibXtw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+lLGTFhIW8e6BbP4ktrJ97TRkQOQP9YGkndC/a0CGaokR3++
	bGP3z2qJIv1uOGZ/Llb8HoCzwle6Of4FDCKs0lz3W24JI/YHwBxA7h2F+6QVOSla4lignYKIEOq
	nXeLHihncnj5q+rhya+4V3d6SPpGTaeozYKIG
X-Gm-Gg: ASbGnct9P81EMqTJ9u5bHdPIlMgKxfnpiwAkWV69SFfHp5FmNOr3XzWgDP0xCsJS/34
	Jm0WoXRyY76E6zX7rVcSlwE6+JVIWDjiPbK8kU7lSqHfTIscZprXTrqI3uywLlIT0W24kIUmkEe
	FDSfnnlIQAub7Ph4k/IdflwfN7ZLs=
X-Google-Smtp-Source: AGHT+IEAPPIMwgc8pOWLVfHmc8590fFetXt39GhCXdv8bLiU91UCU1Au9gUm97JBUiOisd/svkoP6+3U8ev6aLY1jMM=
X-Received: by 2002:a05:6512:ad1:b0:545:617:6ee0 with SMTP id
 2adb3069b0e04-54990ead1a6mr3563172e87.33.1741505734598; Sat, 08 Mar 2025
 23:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com>
 <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com> <CAGdbjm+vuSDO_Zm4CiJgVEx1vx+LAT1+fVQG8xj41uYhBY9qkA@mail.gmail.com>
In-Reply-To: <CAGdbjm+vuSDO_Zm4CiJgVEx1vx+LAT1+fVQG8xj41uYhBY9qkA@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Sun, 9 Mar 2025 13:05:21 +0530
X-Gm-Features: AQ5f1JrhIhDuhuLpKK42hc8t8iHrh87HQpS8kmCztthqtqVv-rpaKoMoUKA9TMk
Message-ID: <CAD2QZ9acg0Z6dT90saG7D9U+oNMCnoskZY=+0pxaDXSXbauTLw@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Kevin Loughlin <kevinloughlin@google.com>, Borislav Petkov <bp@suse.de>
Cc: bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b6599e062fe3e60a"

--000000000000b6599e062fe3e60a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 4:26=E2=80=AFAM Kevin Loughlin <kevinloughlin@googl=
e.com> wrote:
>
> > > > For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI=
.
> > > > In this case, mpparse_find_mptable() has to be called to parse MP
> > > > tables which contains boot information.
> > > >
> > > > Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation =
for SEV-SNP guests")
> > > > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > > > Signed-off-by: Ye Li <ye.li@broadcom.com>
> > > > Tested-by: Ye Li <ye.li@broadcom.com>
> > > > ---
> > > >  arch/x86/kernel/cpu/vmware.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmw=
are.c
> > > > index 00189cd..3e2594d 100644
> > > > --- a/arch/x86/kernel/cpu/vmware.c
> > > > +++ b/arch/x86/kernel/cpu/vmware.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <linux/export.h>
> > > >  #include <linux/clocksource.h>
> > > >  #include <linux/cpu.h>
> > > > +#include <linux/efi.h>
> > > >  #include <linux/reboot.h>
> > > >  #include <linux/static_call.h>
> > > >  #include <asm/div64.h>
> > > > @@ -35,6 +36,8 @@
> > > >  #include <asm/apic.h>
> > > >  #include <asm/vmware.h>
> > > >  #include <asm/svm.h>
> > > > +#include <asm/mem_encrypt.h>
> > > > +#include <asm/efi.h>
> > > >
> > > >  #undef pr_fmt
> > > >  #define pr_fmt(fmt)    "vmware: " fmt
> > > > @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
> > > >                 pr_warn("Failed to get TSC freq from the hypervisor=
\n");
> > > >         }
> > > >
> > > > +       if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > > > +           !efi_enabled(EFI_BOOT))
> > > > +               x86_init.mpparse.find_mptable =3D mpparse_find_mpta=
ble;
> > >
> > > As far I know, Linux itself currently doesn't PVALIDATE the address
> > > ranges scanned in mpparse_find_mptable(), and Linux accesses these
> > > addresses as encrypted during early boot. Given this, am I correct
> > > that the guest firmware that you're using is doing the PVALIDATE of
> > > these ranges before starting Linux (else there would be a crash upon
> > > scan)? And then presumably the firmware is also making sure that this
> > > memory is encrypted so that Linux isn't reading unencrypted data as
> > > encrypted (i.e., garbage)?
> >
> > Yes, Linux (as a guest) receives valid data.
> >
> > > If so, does that mean all the ROM region scans removed in [0] are
> > > permissible for SEV-SNP guests booting on whichever guest firmware
> > > this is? But you only want/need the mptable info here?
> >
> > Yes, VMware firmware validates MPTABLE info when 'non-EFI guest boots
> > on VMware Hypervisor'. The other ROM regions removed in [0] were not
> > encrypted and validated. This is a specific use case for the VMware pla=
tform.
> > Linux today assumes SNP VMs will be booted with UEFI.
> >
> > > [0] 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for
> > > SEV-SNP guests")
> > >
> > > More broadly, ideally the guest firmware would communicate to Linux
> > > that these ranges are safe to access (perhaps via the e820 table),
> > > rather than Linux making the assumption that the ranges are safe for
> > > non-EFI SEV-SNP guest boots in this scenario. However, since you're
> > > only changing vmware_platform_setup() for such boots, I don't think w=
e
> > > need to hold up this patch on that generality.
> >
> > This is a VMware specific scenario. VMware Hypervisor makes the MPTABLE
> > memory available in e820 when 'non-EFI guest boots on VMware Hypervisor=
'.
> > So it makes sense to do the changes only for vmware_platform_setup().
>
> Works for me. Just wanted to make sure we don't regress Linux to
> making assumptions about the safety of accessing memory regions in
> CoCo guests without having entries in the e820 table for them.
>
> Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>

Adding 'Borislav Petkov <bp@suse.de>' to this mail.

I am looking for an update on this patch, please let me know
if there are any issues preventing it from being merged, or if
you need any additional information.

Link to patch:
https://lore.kernel.org/lkml/20241219114400.858980-1-ajay.kaher@broadcom.co=
m/

-Ajay

--000000000000b6599e062fe3e60a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPNL
H4dUjipF389DtvS8wBo81congrI2SZIx0HRqLqMPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDMwOTA3MzUzNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFI8FI4IhlFYNxgrf8wk0nmEcypB2z0q6kxDHeKO
JVlW/oNsk0yqWZg61PGPDSMN3FSuwZehPNXjKme1KDnDUoZtw0mIR1gBp2tCDIKwkCo1/tQhsx2W
vW5FzLGtHDCfW0pGHAW62sCIIJoXuqcfobCIB8r4KDLjtF8IoBF+zQwrbkxHrHCneseCw1ilZG1X
sixEDCcMOV80HGjLXpgEqR2mA6ZC3ivy1V3by6qNan6HO97FGqy3Bhq7MSsZ831ufdfq6OOcQOSx
bLVWvGF16yMIVnSN4OlpziGIrL1rHqhb/kp7lPNlEM8VvedMM3IPz2xv50oSj8QmUYiTrkCXyv0=
--000000000000b6599e062fe3e60a--

