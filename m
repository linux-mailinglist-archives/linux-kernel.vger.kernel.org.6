Return-Path: <linux-kernel+bounces-420819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317239D8359
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59D1162E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C91922ED;
	Mon, 25 Nov 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujIsNFxc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F80191F7E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530571; cv=none; b=GtJKPthqiOHKntvlNwWFEZLzw94aCq7SJglC3qnkckqo/9rgPQEZBQ4y/KZvbjmH05eJCnRnlcN/7RgJovHZUbQY7dvllfCLiYj0LHg4FTYZ+Fsi1KIhcxHWbMh/lEPtwtFHb7BCSKTnXyG6s3G+K83Op5akE9vR40TZw57WOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530571; c=relaxed/simple;
	bh=JVUhtawvLDRUwEkfSmuT4HO5ooTjF0Ona9TmzrHap6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nskUoqejxkaxNEpVMfeiGSMDmIozj0nPx+kHCUz5hc7c7sT25A/mE4NPy8N/dQ/FD832OQ6RfaI+N0XPRfMWpf0nwJiz4Mkdni9xpTlPBi8iewP1nmnABBvXGH7p+utsAJWf+PH+cWaxY8caLmzRWbTivWmrS9fjiKTxxcHFF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ujIsNFxc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yhWCNY2theg2cAIcWvRbdJeosieUTNG76cgsiJbqd8g=; b=ujIsNFxc4cCSbe0ujQ/UAXc+GK
	cKKoHJFIjlkQP6coYbEewFrHX9HCutlrZCmXH1iA0Egg1hD1pLpxJQZnrM4Td7832bhzVdIq4CXmh
	JoKXKTcfKKytiuJmeEOXccsY3Swnh1hZvBxQwq/VRyHLPFzst2y5ZFHxwa+XfKkvzPq+9RAYQ1+d6
	VnpJ3DTzQxJLS1QebT+gd15ZlR3b3tS1kwzRKpDkbuvdjeekOAYNyFo5dSnUd2rYdfARO6Q/U3H5u
	R0bF/ilXwRT7IHe2qW+LGOAQjaQAO7teNOsTardBzjL5kbM8eOw7YbrmHAzzcXdAiLRsPL2RFbw/6
	XjbnRjpA==;
Received: from [54.239.6.187] (helo=edge-m3-r1-122.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWLF-0000000BkB5-3dGI;
	Mon, 25 Nov 2024 10:29:20 +0000
Message-ID: <8b7cd35ab5fec39b80eda8d5907b641af14c3272.camel@infradead.org>
Subject: Re: [EXTERNAL] [RFC PATCH v3 01/20] x86/kexec: Ensure
 control_code_page is mapped in kexec page tables
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org, =?ISO-8859-1?Q?Sch=F6nherr=2C?= "Jan H."
	 <jschoenh@amazon.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, Nikolay
 Borisov <nik.borisov@suse.com>,  linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Dave Young <dyoung@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, jpoimboe@kernel.org,  bsz@amazon.de
Date: Mon, 25 Nov 2024 10:29:17 +0000
In-Reply-To: <20241125100815.2512-2-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
	 <20241125100815.2512-2-dwmw2@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-/rI6/xS8CNfSLar2S82a"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-/rI6/xS8CNfSLar2S82a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-11-25 at 09:54 +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The control_code_page should be explicitly mapped into the identity
> mapped page tables for the relocate_kernel environment. This only seems
> to have worked by luck before, because it tended to be within the same
> 2MiB or 1GiB large page already mapped for another reason.
>=20
> A subsequent commit will reduce the control_code_page to a single 4KiB
> page instead of a higher-order allocation, and seems to make it much
> *less* likely that we get lucky with its placement. This leads to a
> fault when relocate_kernel() first tries to access the page through its
> identity-mapped virtual address.

This one is confusing me. Jan points out that it shouldn't be needed,
because the control page should come from kernel memory and thus should
be mapped anyway because the loop immediately below my added code adds
*all* of the pfn_mapped[] ranges.

And from code inspection he appears to be right, but if I disable the
new mapping and add some printks...

--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -247,15 +247,18 @@ static int init_pgtable(struct kimage *image, unsigne=
d long control_page)
                info.direct_gbpages =3D true;
=20
        /* Ensure the control code page itself is in the direct map */
+       pr_info("No Map control page at %lx", control_page);
+#if 0
        result =3D kernel_ident_mapping_init(&info, image->arch.pgd, contro=
l_page,
                                           control_page + KEXEC_CONTROL_COD=
E_MAX_SIZE);
        if (result)
                return result;
-
+#endif
        for (i =3D 0; i < nr_pfn_mapped; i++) {
                mstart =3D pfn_mapped[i].start << PAGE_SHIFT;
                mend   =3D pfn_mapped[i].end << PAGE_SHIFT;
=20
+               pr_info("Map pfn_mapped[%d] %lx - %lx\n", i, mstart, mend);
                result =3D kernel_ident_mapping_init(&info, image->arch.pgd=
,
                                                   mstart, mend);
                if (result)


... and run in a version of qemu which dumps the CPU state on triple-
fault...

+ ./loadret
[    0.948097] kexec: No Map control page at 2b32000
[    0.948103] kexec: Map pfn_mapped[0] 0 - 7ffdd000
[    0.960192] Freezing user space processes
[    0.961685] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[    0.962372] OOM killer disabled.
[    1.088668] ata2: found unknown device (class 0)
[    1.095810] Disabling non-boot CPUs ...
[    1.117990] smpboot: CPU 1 is now offline
[    1.118595] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
RAX=3D0000000080050033 RBX=3D0000000000000000 RCX=3D0000000000000001 RDX=3D=
0000000000400000
RSI=3D0000000002b3205a RDI=3D0000000003a44002 RBP=3Dffff9709c2109400 RSP=3D=
0000000002b33000
R8 =3D0000000000000000 R9 =3D00000000038a0000 R10=3D0000000000000000 R11=3D=
0000000000000001
R12=3D0000000000000000 R13=3D0000000000170ef0 R14=3D00000000fee1dead R15=3D=
0000000000000000
RIP=3Dffff9709c2b32057 RFL=3D00010006 [-----P-] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
FS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
GS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
LDT=3D0000 0000000000000000 00000000 00000000
TR =3D0040 fffffe2fb91b2000 00004087 00008b00 DPL=3D0 TSS64-busy
GDT=3D     0000000000000000 00000000
IDT=3D     0000000000000000 00000000
CR0=3D80050033 CR2=3D0000000002b32ff8 CR3=3D00000000038a0000 CR4=3D00170ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000=20
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000d01
Code=3D04 00 00 49 89 cb 48 8d a6 00 10 00 00 48 81 c6 5a 00 00 00 <56> c3 =
cc 6a 00 52 48 8d 05 8c 04 00 00 50 66 ff 30 0f 01 14 24 48 83 c4 0a 8c d8 =
8e d8 48


RIP xxx057 is here, where relocate_kernel first touches the 1:1 mapping of =
the control page:

        /* setup a new stack at the end of the physical control page */
        lea     PAGE_SIZE(%rsi), %rsp
  49:   48 8d a6 00 10 00 00    lea    0x1000(%rsi),%rsp

        /* jump to identity mapped page */
        addq    $(identity_mapped - relocate_kernel), %rsi
  50:   48 81 c6 5a 00 00 00    add    $0x5a,%rsi
        pushq   %rsi
  57:   56                      push   %rsi

The control page at 2b32xxx *really* ought to be mapped, as it's
clearly within the 0 - 7ffdd000 range. What's going on?


--=-/rI6/xS8CNfSLar2S82a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMTI1MTAyOTE3WjAvBgkqhkiG9w0BCQQxIgQg1nuzVlcr
tcwZS0Z3FWQI6WDDZxzZR4Zllze3EvOgxfEwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAPWG1utmtMbCF6I8RhZV5keYwCFwn/S4+T
1I4NjNI2AihXWHpOnOk5vVoPSY8zf5eFdHvpkSGf5MvFiix5vusvvCKzbnudeSoUeshiTA5Iq5Z+
YRvYQI6vcv+0od8H0NUssA4KIT5XrPfmKSCI+yYenH4I9mioggvMjRP7qqBVuxr92FlJEU6TIkKY
/FDag4BMXh74ntx0KuSuKFwGArcvLUcE49mFJFYi0P+1DuX0T7NwwWjjVYYpEV2Z4PJwyCGMwgMs
bYA2bPExD/OojVGAtt79Ycswo8twKLwe7jhwQBqLLcAMFSIpid4yTfxaxQQU9/kKoXyPYC3pahDR
9ia+4gbq7CXOJjvNctHTZOTmzHJo6SjQl9jOvnTBZE+BGe40QlV0u70f6xJGXWmD0zS4ZN/L/y+e
oq38nwCPjFIORA7+6mi1NRLLO2v6RpL/eCAEVwEWxznsSr7X1rV8mYsRjoWbdKd1t8k6GuEXq1rl
dSWmQEIErwIpuwLX25rXPUFluf8D7OFT0z4LaxOPWqnksmRptiRPtHzIuHij1krt6g5kN14rRVXg
4PziXNZ0+wM3u3LPkpaEinuWg7mGoRyh1LlnJuLH//BAMRuaINXs73HtVTpAiNVbiXLyBlAbuBGb
7RCldd2svY5czq99y9xM5CmZR5WILKXpNEjt5GlpWQAAAAAAAA==


--=-/rI6/xS8CNfSLar2S82a--

