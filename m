Return-Path: <linux-kernel+bounces-563727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FDA6474C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042543B11C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F341221F1F;
	Mon, 17 Mar 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VZlcjlWE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D0221F0A;
	Mon, 17 Mar 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203661; cv=none; b=U3Q6dYEdm1e2rIRH1kMHFbX3Y/YriApzHQ1/hNW0kFw/bAasyD5XOtaJiH0lSwWdGmRD4mck/HDZmXegQY312hXRr1HqoZ81sTBq+wUIJgrmIoCG0USIDSIYXo0fzf8R7RJ15jwxSuF61J4a5Lq/sSTf290LZy1oFH1vKVeNioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203661; c=relaxed/simple;
	bh=lqjMb32KXXql7Al8fDxkiL8SGiu3Zbnzu5x1H9yEezQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHtX0fsS3Unn9NsnizNsevjVx4XyZ/e8Vt2Ehv2+J9iKfs5IDKfnz2M8I5D2Eguxu5/yKQbHefYAhK4Ay+p/eG6TgErl7O8lk7ezD/os4+5A/d7AK/rgevbdenrZchBsEAztRJcMfV2+vKurlQEZ1UAIeoGrKTQMAA8hclgu9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VZlcjlWE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CTLzdgzNn3MAanDyZN8BjXMkbYJDEvPGI3lVbCinBdU=; b=VZlcjlWE9Sipt4dbpDt/7WciGL
	ouFcpBRZ2PrE6R1JmVSiiPtGkEqAMGe63AXiskgOXqXWOgbfGBsnpk8yVwQhdtgG0nIY6mwRrWlh4
	6EsP1zEiP8oW8Z8awFWNht1/jgecjw6LfLNj2nYBnmoWdH/u0eNLHOWqhL4cZMM2XfdfqhZeHpuZF
	AWL0Yp4K6UndPQDJ90e8+0pKjZJ/hj/lrYL3bCB+DF8e9qt2P0a1CHiT74eb4DVDjNOfQfax1D2aS
	UGu2ihjiUN4xbRc3nfSo8nDfOaMAWsN2KniXUMbOkOtoUsxrG10FRBPwVXKc6mnEpBZSASSlOQdjA
	oTHPipmw==;
Received: from [172.31.31.145] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu6ke-00000003PXn-42Ye;
	Mon, 17 Mar 2025 09:27:17 +0000
Message-ID: <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
From: David Woodhouse <dwmw2@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Huang, Kai"
	 <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org, "Rafael J. Wysocki"
 <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova
 <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, Sean
 Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org,  linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2025 09:27:16 +0000
In-Reply-To: <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
	 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
	 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
	 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
	 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
	 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-mrd/9ZSVcxnQW81VZ+0H"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-mrd/9ZSVcxnQW81VZ+0H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-04-04 at 12:32 +0300, Kirill A. Shutemov wrote:
> On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> >=20
> >=20
> > On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> > > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear i=
t leads
> > > > > > to #VE.
> > > > >=20
> > > > > Will we consider making it more safe and compatible for future to=
 guard
> > > > > against X86_FEATURE_MCE as well?
> > > > >=20
> > > > > If in the future, MCE becomes configurable for TD guest, then CR4=
.MCE might
> > > > > not be fixed1.
> > > >=20
> > > > Good point.
> > > >=20
> > > > I guess we can leave it clear if it was clear. This should be easy
> > > > enough. But we might want to clear even if was set if clearing is a=
llowed.
> > > >=20
> > > > It would require some kind of indication that clearing MCE is fine.=
 We
> > > > don't have such indication yet. Not sure we can reasonably future-p=
roof
> > > > the code at this point.
> > > >=20
> > > > But let me think more.
> > >=20
> > > I think I will go with the variant below.
> > >=20
> > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/r=
elocate_kernel_64.S
> > > index 56cab1bb25f5..8e2037d78a1f 100644
> > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > @@ -5,6 +5,8 @@
> > > =C2=A0=C2=A0 */
> > > =C2=A0 #include <linux/linkage.h>
> > > +#include <linux/stringify.h>
> > > +#include <asm/alternative.h>
> > > =C2=A0 #include <asm/page_types.h>
> > > =C2=A0 #include <asm/kexec.h>
> > > =C2=A0 #include <asm/processor-flags.h>
> > > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > =C2=A0=C2=A0	 * Set cr4 to a known state:
> > > =C2=A0=C2=A0	 *=C2=A0 - physical address extension enabled
> > > =C2=A0=C2=A0	 *=C2=A0 - 5-level paging, if it was enabled before
> > > +	 *=C2=A0 - Machine check exception on TDX guest, if it was enabled =
before.
> > > +	 *=C2=A0=C2=A0=C2=A0 Clearing MCE might not allowed in TDX guests, =
depending on setup.
> >=20
> > Nit:=C2=A0 Perhaps we can just call out:
> >=20
> > 	Clearing MCE is not allowed if it _was_ enabled before.
> >=20
> > Which is always true I suppose.
>=20
> It is true now. Future TDX will allow to clear CR4.MCE and we don't want
> to flip it back on in this case.

And yet v12 of the patch which became commit de60613173df does
precisely that.

It uses the original contents of CR4 which are stored in %r13 (instead
of building a completely new set of bits for CR4 as before). So it
would never have *cleared* the CR4.MCE bit now anyway... what it does
is explicitly *set* the bit even if it wasn't set before?

This is what got committed, and I think we can just drop the
ALTERNATIVE line completely because it's redundant in the case that
CR4.MCE was already set, and *wrong* in the case that it wasn't already
set?

@@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
         * Set cr4 to a known state:
         *  - physical address extension enabled
         *  - 5-level paging, if it was enabled before
+        *  - Machine check exception on TDX guest, if it was enabled befor=
e.
+        *    Clearing MCE might not be allowed in TDX guests, depending on=
 setup.
+        *
+        * Use R13 that contains the original CR4 value, read in relocate_k=
ernel().
+        * PAE is always set in the original CR4.
         */
-       movl    $X86_CR4_PAE, %eax
-       testq   $X86_CR4_LA57, %r13
-       jz      .Lno_la57
-       orl     $X86_CR4_LA57, %eax
-.Lno_la57:
-
-       movq    %rax, %cr4
+       andl    $(X86_CR4_PAE | X86_CR4_LA57), %r13d
+       ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_T=
DX_GUEST
+       movq    %r13, %cr4
=20
        /* Flush the TLB (needed?) */
        movq    %r9, %cr3



--=-mrd/9ZSVcxnQW81VZ+0H
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxNzA5Mjcx
NlowLwYJKoZIhvcNAQkEMSIEIM+ZDlARM66Df0GU2I9/SJ+ATBsL+lBhIUfnQBP1R1qpMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAz/QjAKoqQpgI
hJAZ5WrR8YHKfvPm4N4iodIBoO2molUhB/lts0TtmTdiXhxl0PuLI/f57DZBMqp87U8s0KhWboiC
CNYTorOrxabmKB0V8TTdBvwALD3SmFxljFSnc00jhSEG4dUEThjeHoRCxvGeU5rf5zFIWrYy0ecA
25/wKD1pGFVMZFImwovRzz7H2DDENsxpmIaGctyR7yg8mU/WQ7rn5GxJqfm1dzryB6hnLliX4sGD
/LrtV+U8cbFKk8OgfIsnYWyeaLhE77np4G4am5xXmtaOcPjz4l23q3tuJsYIzmcaPfVgp5IXt63y
DlTWUi/2/gPEsYIfVl/MlrA+6nsxFB6N2yvDrQy/wBRxOTD16tplkA2rNXJI2mQiSmupP4nkp7m6
ld1ADkPUGOeDR+ZtUZEOx2w05Ja83EUUxAYce7RBdtE/3WZGsOYyjejMVTgfQDzY/JN5KJTbkZhO
+YnHtOnT23EfBumdp2ms19HugYbI4w2VTavgp7pYF+JwNdN9cID08OuCFOIUO89+IXQy3B6qpc+J
Wch4hXvmEpFv1ie4c8HK2c9lec/FnUKyBI+0IrMd+NbEtwGQf8x+uDEpuw7PwVpGRYBDFjh83nTY
L5oFKyZJwe2+iBbPs24WGn96gTiNCWbqn2c8TW+mY2h+sZx03W3itZ2qe8zoTA8AAAAAAAA=


--=-mrd/9ZSVcxnQW81VZ+0H--

