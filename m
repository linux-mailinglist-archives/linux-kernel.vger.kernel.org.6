Return-Path: <linux-kernel+bounces-443531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694AB9EF655
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6322517CDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6A229664;
	Thu, 12 Dec 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="favOzIhB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F52288CD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022818; cv=none; b=kAoRrgqd5FT+4dhCShOFMZIbeHGYpvbMUidXPN/iwZBqAQH+1pJh97jRISF+fFHwSo0xfUL4fySVmherDZ9+ERceJQrp1Dec7R9/+2KGL4bg+mYnamoT1XeW2L9MMRjUKYm3aZFhCdZIBclx5R/VrCxi+pMc1LtRr5uOnkU76ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022818; c=relaxed/simple;
	bh=Io3WvucjizRAirjKnhlp++q1B2NlLbZNLYprp+NfeEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHRfzY4o40pLfiqZQMTjg0ogCmiwtqYEzhLh/pDo4c8eHdgXWwbdw5Aq5wCULsDPSZ/AkcT+W1IFeytIJ5BpBZwiCBozArxIiiw06OZnIohOGr2DnBDYORwOfMsPufzT/lQFtmGK0OwyuMEtS7O3LqqMaUlDs072KFKo7qnV2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=favOzIhB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZhgJZr3qWee9gpuHvgnSKH12MexXSa7FFIcE5oueOz4=; b=favOzIhBK0nNj8SpBeZk32X0ab
	19fK2Dl7Y1QfYZP8egJU3amlN2WBWTffri33HHx+kot/pytDnwLzBcraWojw7jTWwgtFfWqWABeg+
	6ZydRBLASemRrO8JicT38rmrM1hDSLQHmqfZOG1Sztzee53pDZfdlCc1t7oj7E54DaIAg6QqxfBNQ
	PUirpCDnOQ0MPMEZB4YKNE4nDj78SvtzPmYA9N0sySBHoBwz3T1+q2tlhlm4Z0OPtk71xzuBwtpUp
	zzrMAIWxuYPZUMAmbrj76zDegxwLYOdQX2tk/cm51Gccd2E8gFj5HHQc8uUBpRLd0vtiZs0/5gL8Y
	l/327uFQ==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLmXh-00000006ttm-33vt;
	Thu, 12 Dec 2024 17:00:01 +0000
Message-ID: <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
From: David Woodhouse <dwmw2@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,  "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, Nikolay
 Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Dave Young <dyoung@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, jpoimboe@kernel.org, bsz@amazon.de
Date: Thu, 12 Dec 2024 17:00:00 +0000
In-Reply-To: <20241212150408.GA542727@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
	 <20241205153343.3275139-14-dwmw2@infradead.org>
	 <20241212014418.GA532802@ax162>
	 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
	 <20241212150408.GA542727@ax162>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-6dSxTWcPqVwL29kY8xvb"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-6dSxTWcPqVwL29kY8xvb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>=20
> Here is the output that I see with that patch applied when rebooting via
> 'systemctl kexec':
>=20
> RAX=3D000000010c070001 RBX=3D0000000000000000 RCX=3D0000000000000000 RDX=
=3D000000047fffb1a0
> RSI=3D000000011c444000 RDI=3D000000011c450002 RBP=3Dff1cd0424d6e8c00 RSP=
=3Dff4178d5c5aebc60
> R8 =3D0000000000000000 R9 =3D000000011c446000 R10=3Dffffffff909f3e00 R11=
=3D0000000000000003
> R12=3D0000000000000000 R13=3D0000000000000001 R14=3D00000000fee1dead R15=
=3D0000000000000000
> RIP=3Dff1cd0425c44401c RFL=3D00010002 [-------] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
> ES =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS=C2=A0=C2=A0 [-WA=
]
> CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
> SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS=C2=A0=C2=A0 [-WA=
]
> DS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS=C2=A0=C2=A0 [-WA=
]
> FS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS=C2=A0=C2=A0 [-WA=
]
> GS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS=C2=A0=C2=A0 [-WA=
]
> LDT=3D0000 0000000000000000 ffffffff 00c00000
> TR =3D0040 fffffe043fedb000 00004087 00008b00 DPL=3D0 TSS64-busy
> GDT=3D=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000 00000000
> IDT=3D=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000 00000000
> CR0=3D80050033 CR2=3Dff1cd0425c4441de CR3=3D000000011c446000 CR4=3D00771e=
f0
> DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
> DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
> EFER=3D0000000000000d01
> Code=3D41 57 9c 6a 00 9d 0f 20 d8 4c 8b 0d ee 01 00 00 41 0f 22 d9 <48> 8=
9 25 bb 01 00 00 48 89 05 c4 01 00 00 0f 20 c0 48 89 05 b2 01 00 00 41 0f 2=
0 e5 4c 89

...

> I have attached the output of 'objdump -S'. Please let me know if you
> would like any other information or testing.

	/* Switch to the identity mapped page tables */
	movq	%cr3, %rax
   e:	0f 20 d8             	mov    %cr3,%rax
	movq	kexec_pa_table_page(%rip), %r9
  11:	4c 8b 0d 00 00 00 00 	mov    0x0(%rip),%r9        # 18 <relocate_kern=
el+0x18>
	movq	%r9, %cr3
  18:	41 0f 22 d9          	mov    %r9,%cr3

	/* Save %rsp and CRs. */
	movq    %rsp, saved_rsp(%rip)
  1c:	48 89 25 00 00 00 00 	mov    %rsp,0x0(%rip)        # 23 <relocate_ker=
nel+0x23>
	movq	%rax, saved_cr3(%rip)


So it's faulting when it tries to write to saved_rsp, which is the
first instruction after it loads the new page tables into %cr3.

Before loading %cr3, the CPU is running on the original kernel page
tables, It's running from the *virtual* address of the control page,
which in your case is ff1cd0425c444000. In those old page tables, this
control page is read-only.

But in the newly-loaded page tables, this control page should be read-
write.=C2=A0

What CPU is this? Shouldn't loading %cr3 have caused the existing TLB
entry to be flushed?

Can you tell me what happens if we don't write through *that* virtual
mapping of the page, but instead do it a few instructions later through
the identity mapping of the same page (which surely *won't* have an
older, non-writeable TLB entry already...)?



diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocat=
e_kernel_64.S
index 8bc86a1e056a..2763c509e513 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -70,6 +70,18 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
=20
+	/* setup a new stack at the end of the physical control page */
+	lea	PAGE_SIZE(%rsi), %rsp
+
+	/* jump to identity mapped page */
+	addq	$(identity_mapped - relocate_kernel), %rsi
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
+	int3
+SYM_CODE_END(relocate_kernel)
+
+SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+	UNWIND_HINT_END_OF_STACK
 	/* Save %rsp and CRs. */
 	movq    %rsp, saved_rsp(%rip)
 	movq	%rax, saved_cr3(%rip)
@@ -85,19 +97,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
=20
-	/* setup a new stack at the end of the physical control page */
-	lea	PAGE_SIZE(%rsi), %rsp
-
-	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %rsi
-	pushq	%rsi
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
-SYM_CODE_END(relocate_kernel)
-
-SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
-	UNWIND_HINT_END_OF_STACK
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address


--=-6dSxTWcPqVwL29kY8xvb
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjEyMTcwMDAwWjAvBgkqhkiG9w0BCQQxIgQgNikioKRg
b3PshUr12AVhBhHHhj9hkcmu3PmFHBk2EMgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgA2/OMMRITPZbqJ7e1CWbZPJFpjjG0/L5lG
2wiHnBSnMLw92CLQT9Rx18P/z1Phtnz2BlNfk5KhZkGEovCZ6NJ3GH7FBq995h2TVPnm09LZoRVo
+gcw2KDbZRbfpM1xayFtz2lSfhDeH6iV7jhlGe9lOAA2thXEZgNHcChTDGlk04wgc7ccEAWMfbwG
ZYmNX+xQcEcgPZ7YM9+0eap9aCAeGNOgx9n46v/hzX7yGDsL6RQ7UEbeW+GqrMPwsoh/tXW6ZhMQ
gVIDle2cA/AumtiWlH4f8M59U9U49zTeMFQXosCH+ssljXz3i4uXVjPvfMJ3sSTIVYYsv0rMcXL0
YpuPO3gGylAkpfRdWadyJJSUQ9idyZnNFUk5vdv18cWbVoaNzTD7mnAx2IdqgwfwSReEgFTnBBB9
OFI6HZxEPjZ6QTzEayMrTitSsbuP9zn0OxLB3H/L2E4ZxIvuR7gXP7q3Bwk7g4ePk3qOj75ZTNxQ
QVUJku94fwv+1mKk2waK17b9enHDEvY0KbffDC7PvzuDrCJzbTzcog13qJZSsgAqwft2UVr958IB
lWpfzWGpvOV6TqxL+NOpaE8byTeChbY6eD3ew+tbbI6aQVjhCeB0SFX3jM5CkUTmFSp44gGa5Mkx
2d0U6i6vANjPg1/QzhDlzcGZMeUK1x0Wu4ePPpKkUAAAAAAAAA==


--=-6dSxTWcPqVwL29kY8xvb--

