Return-Path: <linux-kernel+bounces-564049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DEA64CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E0E3AFDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75423373A;
	Mon, 17 Mar 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2PuBXJf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9418199E8D;
	Mon, 17 Mar 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211177; cv=none; b=s8dQqlswHX3e+kvUv7OFVxMV+4j/K0s/p/E3mJFTEO09i9B4xBgfHDxA23iTOy2nTBQ6Sz2w4duOAeTAsjOW9bTIYRMZZuAEOU39LzL3wcdsnyjrdueGrzkQqmR/gwYgOUJ8hIuOUCpUi7zqcj2B1JtG428FWKtNzmNnGjBWWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211177; c=relaxed/simple;
	bh=/cYZCglc0Pv+ttWDTWNBJnjiozlHcKBYPMKUUic6Rgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBMDDp/TmthF5/3xCzpQ0BhPMhR56uBCzVDMwEWPBihJxcM0wNBti9his/Mlhnz4tSlPCYJHaDcjiqlsb8DiNwTtVi2uG9Ux/8d/W/NZjtIPkFksbnaJLcuTFeEddnU834oePC2Mwvidzfd46HMiQTIRze0+XNh6NfZfJxFF2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C2PuBXJf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gfF/1bRm0RuluxE0IUuhjPZ2xx5PQlvpgJJ1VyBIwcc=; b=C2PuBXJfyBvlXlPHy/gJ2YAFND
	CE/LvaCEqKNAwXZkNZca1tR9dVotuZ2mwYGjqrRtrPfYoHQKymMcrJYa8v0m/arYptKI0NXSDU7Vw
	G0hO3UK021H6Ff8mh1Nt5ooCbRaxfC48H0He/rgS0C49Li9QiVd+Wft6jalilFeOittUmQIZtC3IK
	A8gvqEBv2tQXVbGsoqYh5ajAz3cmrlWbEKlGDfx5P9PIGoJiB462Bgbl0yrCDbMJvWtkLb2QLWWSg
	tirzqfbubGn41RoPLfwg1jA8KaIvJv2hDRd1LcJgW1dAEHP3+MDxxsQ4NqgiiCkNCI0bSrXlaT+rN
	3YaqL86Q==;
Received: from [172.31.31.145] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu8i3-00000003Qtj-0Ief;
	Mon, 17 Mar 2025 11:32:43 +0000
Message-ID: <0c6cab4ea4e898a62ecb0b047959f09011d3c85f.camel@infradead.org>
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
From: David Woodhouse <dwmw2@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2025 11:32:42 +0000
In-Reply-To: <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
	 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
	 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
	 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
	 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
	 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
	 <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
	 <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-N/CVzyDGKpIYhn/J/7wO"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-N/CVzyDGKpIYhn/J/7wO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-03-17 at 13:03 +0200, Kirill A. Shutemov wrote:
> On Mon, Mar 17, 2025 at 09:27:16AM +0000, David Woodhouse wrote:
> > On Thu, 2024-04-04 at 12:32 +0300, Kirill A. Shutemov wrote:
> > > On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> > > >=20
> > > >=20
> > > > On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > > > > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrot=
e:
> > > > > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to cle=
ar it leads
> > > > > > > > to #VE.
> > > > > > >=20
> > > > > > > Will we consider making it more safe and compatible for futur=
e to guard
> > > > > > > against X86_FEATURE_MCE as well?
> > > > > > >=20
> > > > > > > If in the future, MCE becomes configurable for TD guest, then=
 CR4.MCE might
> > > > > > > not be fixed1.
> > > > > >=20
> > > > > > Good point.
> > > > > >=20
> > > > > > I guess we can leave it clear if it was clear. This should be e=
asy
> > > > > > enough. But we might want to clear even if was set if clearing =
is allowed.
> > > > > >=20
> > > > > > It would require some kind of indication that clearing MCE is f=
ine. We
> > > > > > don't have such indication yet. Not sure we can reasonably futu=
re-proof
> > > > > > the code at this point.
> > > > > >=20
> > > > > > But let me think more.
> > > > >=20
> > > > > I think I will go with the variant below.
> > > > >=20
> > > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kern=
el/relocate_kernel_64.S
> > > > > index 56cab1bb25f5..8e2037d78a1f 100644
> > > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > > @@ -5,6 +5,8 @@
> > > > > =C2=A0=C2=A0 */
> > > > > =C2=A0 #include <linux/linkage.h>
> > > > > +#include <linux/stringify.h>
> > > > > +#include <asm/alternative.h>
> > > > > =C2=A0 #include <asm/page_types.h>
> > > > > =C2=A0 #include <asm/kexec.h>
> > > > > =C2=A0 #include <asm/processor-flags.h>
> > > > > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mappe=
d)
> > > > > =C2=A0=C2=A0	 * Set cr4 to a known state:
> > > > > =C2=A0=C2=A0	 *=C2=A0 - physical address extension enabled
> > > > > =C2=A0=C2=A0	 *=C2=A0 - 5-level paging, if it was enabled before
> > > > > +	 *=C2=A0 - Machine check exception on TDX guest, if it was enab=
led before.
> > > > > +	 *=C2=A0=C2=A0=C2=A0 Clearing MCE might not allowed in TDX gues=
ts, depending on setup.
> > > >=20
> > > > Nit:=C2=A0 Perhaps we can just call out:
> > > >=20
> > > > 	Clearing MCE is not allowed if it _was_ enabled before.
> > > >=20
> > > > Which is always true I suppose.
> > >=20
> > > It is true now. Future TDX will allow to clear CR4.MCE and we don't w=
ant
> > > to flip it back on in this case.
> >=20
> > And yet v12 of the patch which became commit de60613173df does
> > precisely that.
> >=20
> > It uses the original contents of CR4 which are stored in %r13 (instead
> > of building a completely new set of bits for CR4 as before). So it
> > would never have *cleared* the CR4.MCE bit now anyway... what it does
> > is explicitly *set* the bit even if it wasn't set before?
> >=20
> > This is what got committed, and I think we can just drop the
> > ALTERNATIVE line completely because it's redundant in the case that
> > CR4.MCE was already set, and *wrong* in the case that it wasn't already
> > set?
>=20
> But we AND R13 against $(X86_CR4_PAE | X86_CR4_LA57). We will lose MCE if
> drop the ALTERNATIVE.

Ah, yes.

> And we don't want MCE to be enabled during kexec for !TDX_GUEST:
>=20
> https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.c=
om/

Actually now I've added proper exception handling in relocate_kernel
perhaps we could rethink that. But that's for the future.

> I think we should patch AND instruction to include X86_CR4_MCE on
> TDX_GUEST:
> ...
> -	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> -	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_G=
UEST
> +	ALTERNATIVE __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d), \
> +		=C2=A0=C2=A0=C2=A0 __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57 | X86=
_CR4_MCE), %r13d), X86_FEATURE_TDX_GUEST

Yeah... although the reason I'm looking at this is because I want to
kill the ALTERNATIVE so that I can move the relocate_kernel() function
into a data section:
https://lore.kernel.org/all/20241218212326.44qff3i5n6cxuu5d@jpoimboe/

So I think I'll do it like this instead:

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5081d0b9e290..bd9fc22a6be2 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -65,6 +65,7 @@ extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
 extern unsigned long kexec_debug_8250_mmio32;
+extern uint32_t kexec_preserve_cr4_bits;
 #endif
=20
 /*
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_k=
exec_64.c
index 7abc7aa0261b..016862d2b544 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -353,6 +353,22 @@ int machine_kexec_prepare(struct kimage *image)
 	kexec_va_control_page =3D (unsigned long)control_page;
 	kexec_pa_table_page =3D (unsigned long)__pa(image->arch.pgd);
=20
+	/*
+	 * The relocate_kernel assembly code sets CR4 to a subset of the bits
+	 * which were set during kernel runtime, including only:
+	 *  - physical address extension (which is always set in kernel)
+	 *  - 5-level paging (if it's enabled)
+	 *  - Machine check exception on TDX guests
+	 *
+	 * Clearing MCE may not be allowed in TDX guests, but it *should* be
+	 * cleared in the general case. Because of the conditional nature of
+	 * that, pass the set of bits in from the kernel for relocate_kernel
+	 * to do a simple 'andl' with them.
+	 */
+	kexec_preserve_cr4_bits =3D X86_CR4_PAE | X86_CR4_LA57;
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		kexec_preserve_cr4_bits |=3D X86_CR4_MCE;
+
 	if (image->type =3D=3D KEXEC_TYPE_DEFAULT)
 		kexec_pa_swap_page =3D page_to_pfn(image->swap_page) << PAGE_SHIFT;
=20
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocat=
e_kernel_64.S
index 4f8b7d318025..576b7bbdd55e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -41,6 +41,7 @@ SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
+SYM_DATA(kexec_preserve_cr4_bits, .long 0)
=20
 	.balign 16
 SYM_DATA_START_LOCAL(kexec_debug_gdt)
@@ -183,17 +184,12 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%rax, %cr0
=20
 	/*
-	 * Set cr4 to a known state:
-	 *  - physical address extension enabled
-	 *  - 5-level paging, if it was enabled before
-	 *  - Machine check exception on TDX guest, if it was enabled before.
-	 *    Clearing MCE might not be allowed in TDX guests, depending on setup=
.
+	 * Set CR4 to a known state, using the bitmask which was set in
+	 * machine_kexec_prepare().
 	 *
 	 * Use R13 that contains the original CR4 value, read in relocate_kernel(=
).
-	 * PAE is always set in the original CR4.
 	 */
-	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
-	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUE=
ST
+	andl	kexec_preserve_cr4_bits(%rip), %r13d
 	movq	%r13, %cr4
=20
 	/* Flush the TLB (needed?) */


--=-N/CVzyDGKpIYhn/J/7wO
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxNzExMzI0
MlowLwYJKoZIhvcNAQkEMSIEIIIx9ilTqaZP3C4whhmHOawHnD8g2kGrLH4WrnX3UiCGMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAhxCjL35NGHM4
D0jPD/gHtLciO7dEwetkdx8AXbUsw7NOOV97rtYpj7kemGudLjeRstwsp0UPo5GgPIM50Sn9/Ilk
UPpmU51mITSyeze+ViWlG8GmLoHQikw2NzRoh1iKjw0Xi9kxPgpriiNv/dlR7JTqBFK7e1QStQFy
aSqlB+3bt/+AWi5SG/B/e+gCi7v0G8gvZuqIliwTkapc4J1IDR12lF+xCP1k8KDRNfItGjntseeJ
qpN7NFlLpuLxBMFEVe9smLnqnRwowZPZ51bf9n+74MxZLH7jOUSbFTgnfJna4p6QcBJuC+yR7Y5H
pJZ9gEcWNXj0gymDAwN1kSFcLM/wgJm62W1Q/KD0wMAwuJw9MUwi7S01fQIoE9pPcoV9RlYM1rxP
sQV1TLbi/1Phc8pYu1bF0oC0GkaveecJQMiv53O6T2yifCa4tm5D1NhYZKNUfVUAOenp01iy/RIX
8Y4VfJnxawToqvF1/QwjWnr5WIfX8cGYFIYfouNVWsCh9NtQqfVMmGe2l+cN5Oo+pM1IHIkmrWj6
evsrwZ/CdUfpQwhlpJJYltz4f6Y9lKmefdJBfAI7mS4RBIA2MNjH+l2rpnUi7LWTuMx+cDvj8OsQ
v9r2gxs10KaYEAsZpoYJao3aWE4BbPJ+YUZM9xKnVHzJfmiwtUpK20/3Ci210kkAAAAAAAA=


--=-N/CVzyDGKpIYhn/J/7wO--

