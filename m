Return-Path: <linux-kernel+bounces-566474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46ADA67880
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E703B0EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4420FA9E;
	Tue, 18 Mar 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuNtVPLr"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97618A959
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313417; cv=none; b=DCixmq/4xxebMfC3KUliQvSEPpj+BOXZnRBIepBZKZGTKsuugivwizOvglrXN7FMhseoN7S/doOxKudqNZnZPmxEY/WB8e2aQKsScMNDbKJudPKs1zuFMsM691LNH6LDaS46uyty+RRiYW0Wle+rwsR/toJ1gyNyKJqa0XqbYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313417; c=relaxed/simple;
	bh=VG4SMQratI31tH+YR+I9DGHIrzANmB3r4Dp0SlA/Bgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdRYv3Yi5EN9IIxoL09rKBDwf3pVAnM1ynKb7/I6s9BxnXruZMw3jH5xA3oiwSTCUdhahId4895sgZJDGxde8WLY0BHdXz2yB/sCCo+1lbprCkZhZh8VGA2szfFISb14mwKkD5x8r5K/t7W2NMc433KPgidyaok/g/s57gM9vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LuNtVPLr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bNfNT5xBB0sEGxJGNIWfBo0Vfe0dlizDCeRonkZedC0=; b=LuNtVPLru+xJ32uoK6rI9yDJOZ
	mJwUdAAogEr/VVQPDedXy5YRa/J7TVWVc9bJEJ956sDKd+EJ81qWJRBON9SgDKdGWALHtMh3eFKRd
	1gEmOzbOVGP/hxRPu6gyk1qwhXWDKiyfJolbAeeSbtImjwarll90EMbcuXWPJZaqUCm+PrfGQkk+k
	v00iyIw0MKG7RVTGJelLzlUUeicOu7WUAZPm/dtR69SBA1Q4P0UGSXjv1ZEZe07WoH2Xi10yZauoa
	446fjANgQa7pUNeVhkKEpPoI1LOOSbP5h6eYuj0wQ3piR4eN3Khqqh5/2zsx8WJEao5scqzuBj6+W
	FXHR/4pg==;
Received: from [172.31.31.145] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuZIy-00000003oWW-1EkK;
	Tue, 18 Mar 2025 15:56:36 +0000
Message-ID: <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
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
Date: Tue, 18 Mar 2025 15:56:36 +0000
In-Reply-To: <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
	 <20250312144257.2348250-9-dwmw2@infradead.org>
	 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
	 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
	 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
	 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
	 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
	 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Yiv5GHSgtdb6I3rz0Zfm"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-Yiv5GHSgtdb6I3rz0Zfm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-03-17 at 17:24 -0700, Josh Poimboeuf wrote:
> On Mon, Mar 17, 2025 at 05:17:24PM -0700, Josh Poimboeuf wrote:
> > On Mon, Mar 17, 2025 at 12:40:14PM +0000, David Woodhouse wrote:
> > > On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
> > > >=20
> > > > IIRC, the reasons were the patched alternative, and also you
> > > > wanted to
> > > > disassemble (but note that's still possible with gdb).
> > >=20
> > > It's meaningful output from 'objdump -S' that I miss. But OK.
> >=20
> > FYI, this works:
> >=20
> > =C2=A0 objdump -Srw -j .data..relocate_kernel vmlinux.o
>=20
> ... but I see now that it doesn't intersperse the source.=C2=A0 Never
> mind...

To be fair, the source is assembler. So it isn't *so* hard to work it
out.

But on the whole, I'm not sure the CFI check is worth it.

CFI checks that the caller and callee agree about the prototype of the
function being called. There are two main benefits of this:

 =E2=80=A2 to protect against attacks where function pointers are substitut=
ed
   for gadgets.

 =E2=80=A2 to protect against genuine bugs, where the caller and the callee
   disagree about the function arguments.

For the relocate_kernel() case I don't think we care much about the
first. Without a CFI prologue, no *other* code can be tricked into
calling relocate_kernel() =E2=80=94 and besides, it's in the kernel's data
section and isn't executable anyway until the kexec code copies it to a
page that *is*. And the kexec code itself isn't just following an
arbitrary function pointer; it copies the code into the control page
and invokes it there, so it's unlikely to follow a bogus pointer
either.

It's the *second* benefit which is more relevant to us, ensuring that
the caller and the callee genuinely do agree about the prototype.

But using the SYM_TYPED_FUNC_START() macro doesn't give us that; the
CFI prologue of the asm function is just using the signature emitted by
the *caller* in the weak __kcfi_typeid_relocate_kernel symbol anyway,
so they're never going to disagree. And how *could* the assembler side
build a typeid signature from the asm anyway?

I suspect that just leaving it marked __nocfi is probably the easier
option, unless I can *hardcode* the function signature 0x19835999 in
the CFI prologue in relocate_kernel_64.S to protect against someone
accidentally changing the C-visible 'relocate_kernel_fn' typedef
without changing the corresponding assembler? But honestly, is that
likely?

Looks like this (with your objtool relaxation on top, as well as
removing load_segments() in machine_kexec_64.c if I want the check to
actually emit the warning correctly.).

I just don't think it's worth it...

=46rom 1bbed9c611fd286b68e2c459320910c4fefd4a22 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 16 Dec 2024 10:26:24 +0000
Subject: [PATCH] x86/kexec: Add CFI type information to relocate_kernel()

A previous commit added __nocfi to machine_kexec() because it makes an
indirect call to relocate_kernel() which lacked CFI type information,
and caused the system to crash.

Use SYM_TYPED_FUNC_START() to ensure that the type information is
present, and remove the __nocfi tag. And emit the *actual* type
signature (0x19835999) because by default, asm code uses the type
signature emitted by the *caller*, which is never going to differ!

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   |  2 +-
 arch/x86/kernel/relocate_kernel_64.S | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 814af7fa6318..428401e55d29 100644
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
@@ -67,8 +68,24 @@ SYM_DATA_END(kexec_debug_idt)
  * a data section even of the object file, to prevent objtool from having
  * opinions about it.
  */
+
+#ifdef CONFIG_CFI_CLANG
+/*
+ * The SYM_TYPED_FUNC_START macro emits a CFI prologue for the function,
+ * referencing the __kcfi_typeid_##name symbol which is the signature of
+ * the function prototype. The value of that symbol ends up coming from
+ * a weak symbol emitted by the *caller* (in this case machine_kexec()),
+ * which means it's *entirely* useless for checking that the caller and
+ * callee agree about the prototype of the (asm) function being called.
+ * So, we define the signature *here* for ourselves, and if the C code
+ * ever calls relocate_kernel() in the belief that it has a different
+ * prototype, then the CFI check will trigger as $DEITY intended.
+ */
+	.weak __kcfi_typeid_relocate_kernel
+	.set  __kcfi_typeid_relocate_kernel, 0x19835999
+#endif
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_TYPED_FUNC_START(relocate_kernel)
 	/*
 	 * %rdi indirection_page
 	 * %rsi pa_control_page
--=20
2.48.1



--=-Yiv5GHSgtdb6I3rz0Zfm
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxODE1NTYz
NlowLwYJKoZIhvcNAQkEMSIEIMtPXaFweXScOPVWhPBZ8it2AZD+Guj6VCBpONe5JyQXMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAYGDbakt2nUu5
BueoG2IRQKyL0/4HtThXqFqe5ewIrE5pfBAPhHrfXOftQ8SIPj9Q+PAaR5q4S81eBdrogzD9NxOt
txIYxulex+Gz1kNook1GRHiT2wqU2dkQb6wzdIKbc1Qm+vE37zT+zJjhDOSJMIXBC1VblOsHFTQz
fWzqpOPTsUN8kF2TKRecI0Bt6qJF7xkBj3hcjz3gT0zBPxhj/garpe6vF3cSwa2B/Hl50HwpIxqj
CyiDHX7+xnDYuc/A1FJwxA02B1ae2TJPug4OZ3HaKJ/3A85iOyqYpJtRv4PU6xHHlUypCD14PMmp
6bM8XwObgoK0GSSDYhDSwGG7u8fZvuH5eRsMYUnU/w1ww2LBLU05CfWRKIrhTKddLexAmHBbtlUa
XxfCTLGIiM4ZN67lDoUUGhrlpjAttBOyRyf2EvCvR0hV1sm29+Q9awqzkd+9Acpgr6Kx5RbQYhaW
js03zIifanXDB7Gx3lB9RT3mpfFEMMgJ1auayk4FFyTqwxVz9ZuI5KZCFHNkqsIudQ2vvvyD8L32
TUPcl30qnx+jlVELwDu4d77YnMwmB8l5n4/qlXkg2qJLsJjpD7TmikYWguzmQO7Ov6LqKa7iTPO0
eBmxwlvGHQUCe5foHVAczWUGVJKSqhKm3aBwDrFYAVLhE4zDmiQOO+KGb2AmHycAAAAAAAA=


--=-Yiv5GHSgtdb6I3rz0Zfm--

