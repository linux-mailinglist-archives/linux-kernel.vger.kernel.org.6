Return-Path: <linux-kernel+bounces-564168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C14A64F68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82FB1716BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F023A9BE;
	Mon, 17 Mar 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIUAWoUU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4F18BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215231; cv=none; b=QHDzNThSdG7H8IhZ+9fy3P8li/Hd25vZACCaTqGWSaeh5WZctrJNqY3Yue56XDJr+wti6PRSilt0qMvDDRPNrpjMChkxdafp0jdI0gvOn2o2xvMc4fbuO5zPk/FnYDs+whXGizj+WyMjEVQFoaSXGjLsvmwLWqtcgAQK3d7G3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215231; c=relaxed/simple;
	bh=yTcmVowMkA0+6UhAs6VqDz0plbWsIZfyJ40rvK1z5a8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkctD/smRo116cElKtXVnCAgwYxn01cRK/cqEcmPpTVDRr1me94x8sGDuCsO6h6g0JUF3gRzl9qsvq1w2WVVeZtN44kQuxdztjtR1gabKRBFLStVkmSeTEpPX60sSheVbYR1vpeU0whWKUlIBAJ4HWCVLP0gEMdHoftvmafTJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIUAWoUU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=orPCysawwRPllczDX7Ts+fD7Y7RbEDmQgWfnbJvXvdk=; b=WIUAWoUUBnljhVsYc6y0bn+ux2
	ZUyrDM1AhQxiqMlQ90gaaToSt7ayP7ThXnoQloqkUjD3ftNm+C8ps+dGuzs2K4WRH/v7LSXqtxj0b
	/HSKFagVAwPkSA7xYkYOWDQ/wGuERVvqi24YFNfwO66KgVXf/at04RClJPqi9jl452rrpR/9kMq7q
	nyVOGvUF3mPwiQCiYDcC963OpKiAKXy/k762sHhadHX6jVTrzryCMV38I+ClWZZBLarZUQnOUs2bs
	qc7PhCRd4JD5EmAEhJ0Yxi9m419/jLukkEM7+j49sHN5xmBzwfVZscKABta+jWOEV0ciaKLzszbfn
	A3hwDA6g==;
Received: from [172.31.31.145] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu9lO-00000003RUT-3lev;
	Mon, 17 Mar 2025 12:40:15 +0000
Message-ID: <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>,  "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dave Young
 <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Date: Mon, 17 Mar 2025 12:40:14 +0000
In-Reply-To: <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
	 <20250312144257.2348250-9-dwmw2@infradead.org>
	 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
	 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
	 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-36S8nfd6cdxuk7ghP8WD"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-36S8nfd6cdxuk7ghP8WD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
>=20
> IIRC, the reasons were the patched alternative, and also you wanted to
> disassemble (but note that's still possible with gdb).

It's meaningful output from 'objdump -S' that I miss. But OK.

> Here was a patch to make it work:
>=20
> =C2=A0 https://lore.kernel.org/20241218212326.44qff3i5n6cxuu5d@jpoimboe

I've reworked that and the CR4 filtering, and now it doesn't like me
using SYM_TYPED_FUNC_START() to add the CFI information for the
relocate_kernel() function.

  LD      vmlinux.o
vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for
data symbol .data..relocate_kernel
 ...

  SORTTAB vmlinux
incomplete ORC unwind tables in file: vmlinux
Failed to sort kernel tables

This happens when I build with (clang and) CONFIG_CFI_CLANG, with and
updated version of your patch above, and this on top of it. This is at
https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kexec-d=
ebug

=46rom 0f08a44613764e9b38a1c3332812685b61c99c2e Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 16 Dec 2024 10:26:24 +0000
Subject: [PATCH] x86/kexec: Add CFI type information to relocate_kernel()

A previous commit added __nocfi to machine_kexec() because it makes an
indirect call to relocate_kernel() which lacked CFI type information,
and caused the system to crash.

Use SYM_TYPED_FUNC_START() to ensure that the type information is
present, and remove the __nocfi tag.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 2 +-
 arch/x86/kernel/relocate_kernel_64.S | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_k=
exec_64.c
index 016862d2b544..e1f5fc858aee 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -396,7 +396,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void __nocfi machine_kexec(struct kimage *image)
+void machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start =3D (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocat=
e_kernel_64.S
index 814af7fa6318..c859fbe507e8 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
=20
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/page_types.h>
@@ -68,7 +69,7 @@ SYM_DATA_END(kexec_debug_idt)
  * opinions about it.
  */
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_TYPED_FUNC_START(relocate_kernel)
 	/*
 	 * %rdi indirection_page
 	 * %rsi pa_control_page
--=20
2.48.1


--=-36S8nfd6cdxuk7ghP8WD
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxNzEyNDAx
NFowLwYJKoZIhvcNAQkEMSIEIDeEsHzegrxgjHLbvpIo/1WrbIl614qJFikdRv9Ro6aRMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAuF0NPpCaDBN6
K/Z7DDtKrsghwxusBMKvFAF4Zx5b9GiF9TaL0CeUjNnnDcXf5CH9+v/6OgVTwEQA+oPcimC4UK+n
NhFhXe3Pg8FtHHRka7Wwqhbws0JrG+c/o9yhhRwdct2NpUYs092KWPb/1AZE8MtuAFnMnbIqXr68
Y9+unExHbOcb1qqWauz+13n+ZtBSUeixXg3hkyLQBSYH/cM2GyWXZIC7PpBNPYDmhSpIpcR4/QrR
jGnxaTFzNhyt1byax0Rj/NU6+RSZLOXkOD8ref65GYNaDQlJ4SSeuOrucpV6w1EZwYP4pU2RxJlG
gAxtW5q6rGYk321sBP8+lW4Vj0fiZBIN88NZixeq+yp/uXcgENKUojvbrrs1L/wg1RqBiwAKlO/4
4Sx9fATx/z9kc/VysMvhOZh3Fc0uPy+fSLKc3kAY3hm8m2l6UA7xwSoBZ2wpkUbVx0OEgo59jiUe
dAJ1pfXfxa9Bz1WUCN8y+k7RxNQUHQSsQ3bHjTl4GgX01hYUDk6E4xfApyopT+eGtr0A0pQtbFM6
uCbySZ3mBXdSVDJHYQzPvWWJDbTzGNTp9FTRFwwEsjCIXP4jlDDRJiXT+eiFYA7lJx/GrOSLM82P
zc5tW8XpFGZypw+2O4dg91COIo9VPH3a6WScTSlIqL4Ao1dIk8+8aaVbaKwMBHwAAAAAAAA=


--=-36S8nfd6cdxuk7ghP8WD--

