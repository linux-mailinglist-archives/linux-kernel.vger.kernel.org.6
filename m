Return-Path: <linux-kernel+bounces-421613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61029D8D85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B97F16A1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609B61BB6B3;
	Mon, 25 Nov 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUosSPTk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B210E9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567629; cv=none; b=tVVlHikhHzEIhlBW0vyqHm9eajg24/2d2qCLgLiTcV/UZmRlkxdBlSZj4qjYYVitKfg6JdZiZDS5ZeeyuoxKGHwdXNj4c3otzD/WuZVgTBLQKG4YFPKdnUvUFhhGUncKAZBS6V4I1THFHQO0Baf3H878cHwWk/afVir5vTv5oLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567629; c=relaxed/simple;
	bh=+pIAZJYeMogb8Ct1Pvuz2fyYJgOt+BgUOXJyuiqFgXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uq3GG+8hqtW+3XE9JcJP1qp8zjtto0oTYLbRluYWTz95nqOETzOA73amttKNKJYexPVJB1gU3xDJIsFXfIJqyNUmri2HECW2KNuyOZuEWP6+QrMgP+w3VMqkvhZjlLFKXuQT0FZS4gMimZV2KNRju7vND3ev5ia7JsYCgvYgGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QUosSPTk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9LLQ3sZz+w7S/50UpuL1aGPCs+aMNi0X2DW5WcP/lk=; b=QUosSPTkMcUJyb8atz0CXXuPwX
	rhNj/T04QwkreNg0R8xOINjHfXg80cr032EBCsg5Ee02Ze44aGo5yis10tidDhPQb09twFMOaVjhA
	IDrN2Ryjg8UPX181YCWkD8s759PcB4Twqb9ypgmoFHJ5cy2B1U1KACr5DhcdxfUDh3+mATADKXtkL
	fNs9apltD/NdsxTOvZ3zvthENw2lltGpF14/OdJJMrbPkc0tdDpYTUdpRBvoxT+wozKWE66Q1w/bG
	Gddj4nWcIzgdwU5prPt5QI7Dr3ApuODsF9kQtFXLOj06XdN7D8C5LOaKuHK9nEeJknSbRqRIJmwGX
	WZxyXxUA==;
Received: from [54.239.6.187] (helo=edge-m3-r1-122.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfyy-0000000CT3i-3YPF;
	Mon, 25 Nov 2024 20:46:58 +0000
Message-ID: <8027f85aca2e948ade79b75386bc554c1597ba7e.camel@infradead.org>
Subject: Re: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dave Young
 <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org
Date: Mon, 25 Nov 2024 20:46:56 +0000
In-Reply-To: <Z0TfblQeVRnDc-S1@gmail.com>
References: <20241122224715.171751-1-dwmw2@infradead.org>
	 <20241122224715.171751-17-dwmw2@infradead.org> <Z0RBl6pzNf5irop9@gmail.com>
	 <334ae44077315e2b69529b6fef8d85ec55f80ecf.camel@infradead.org>
	 <Z0TfblQeVRnDc-S1@gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ylLSHkP05cW/RuTahjc4"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-ylLSHkP05cW/RuTahjc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-11-25 at 21:34 +0100, Ingo Molnar wrote:
> =C2=A0
> > The realisation that we never even explicitly mapped the control code=
=20
> > page and always just got lucky because it happened to be in the same=
=20
> > 2MiB or 1GiB superpage as something else that we did map... was just=
=20
> > a bonus :)
>=20
> I'm amazed and horrified in equal measure ;-)

:)

The rest of today was dedicated to finding out that that isn't entirely
true. Mapping the control page explicitly was only helping because it
forced 2MiB mappings instead of a 1GiB mapping, and masked the fact
that PTI was causing the identmap code to scribble off the end of the
root PGD page...

It all just worked by pure fluke on x86_64 before, because x86_64 would
allocate a 8KiB control region and use the first half of it for the
PGD, and *then* copy the trampoline code into the second half, after
the identmap code had finished scribbling on it. So when I cleaned that
up to allocate the PGD separately and explicitly like i386 does, that's
why it exploded; not just due to allocation patterns.

Still, I think I have a handle on fairly much everything that's broken,
except the occasional warning on the way back from
KEXEC_PRESERVE_CONTEXT thus:

[    1.423464] ------------[ cut here ]------------
[    1.423950] Interrupts enabled after irqrouter_resume+0x0/0x50
[    1.424605] WARNING: CPU: 0 PID: 215 at drivers/base/syscore.c:103 sysco=
re_resume+0x152/0x180
[    1.425467] Modules linked in:
[    1.425791] CPU: 0 UID: 0 PID: 215 Comm: kexec Not tainted 6.12.0-rc5+ #=
2015
[    1.426498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.427628] RIP: 0010:syscore_resume+0x152/0x180
[    1.428101] Code: 00 e9 e1 fe ff ff 80 3d b1 b8 c4 01 00 0f 85 21 ff ff =
ff 48 8b 73 18 48 c7 c7 32 b8 b6 ac c6 05 99 b8 c4 01 01 e8 9e 3f 55 ff <0f=
> 0b e9 03 ff ff ff 80 3d 87 b8 c4 01 00 0f 85 b8 fe ff ff 48 c7
[    1.429913] RSP: 0018:ffffae9bc03bfd00 EFLAGS: 00010282
[    1.430445] RAX: 0000000000000000 RBX: ffffffffad6fbb20 RCX: ffffffffad5=
636a8
[    1.431153] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00001
[    1.431869] RBP: 0000000028121969 R08: 0000000000000000 R09: 00000000000=
00000
[    1.432594] R10: ffffae9bc03bfaa8 R11: 7075727265746e49 R12: ffffae9bc03=
bfd28
[    1.433313] R13: ffffffffad471f60 R14: 00000000fee1dead R15: 00000000000=
00000
[    1.434021] FS:  00007f77d4a45740(0000) GS:ffff91d0fd600000(0000) knlGS:=
0000000000000000
[    1.434815] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.435385] CR2: 00007f7e011e7070 CR3: 00000000012fe001 CR4: 00000000001=
70ef0
[    1.436073] Call Trace:
[    1.436334]  <TASK>
[    1.436558]  ? syscore_resume+0x152/0x180
[    1.436956]  ? __warn.cold+0x93/0xfa
[    1.437319]  ? syscore_resume+0x152/0x180
[    1.437717]  ? report_bug+0xff/0x140
[    1.438075]  ? handle_bug+0x58/0x90
[    1.438438]  ? exc_invalid_op+0x17/0x70
[    1.438826]  ? asm_exc_invalid_op+0x1a/0x20
[    1.439246]  ? syscore_resume+0x152/0x180
[    1.439644]  kernel_kexec+0x10a/0x160
[    1.440010]  __do_sys_reboot+0x1fd/0x240
[    1.440485]  do_syscall_64+0x82/0x160
[    1.440863]  ? syscall_exit_to_user_mode+0x10/0x210
[    1.441351]  ? do_syscall_64+0x8e/0x160
[    1.441735]  ? exc_page_fault+0x7e/0x180
[    1.442123]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.442623] RIP: 0033:0x7f77d4b5adb7
[    1.442992] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 =
90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 01 c3 48 8b 15 49 50 0c 00 f7 d8 64 89 02 b8
[    1.444757] RSP: 002b:00007ffc56bc30f8 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a9
[    1.445493] RAX: ffffffffffffffda RBX: 00007ffc56bc3260 RCX: 00007f77d4b=
5adb7
[    1.446173] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[    1.446848] RBP: 00007ffc56bc32c0 R08: 000055e1cef3e010 R09: 00000000000=
00007
[    1.447527] R10: 000055e1cef41020 R11: 0000000000000246 R12: 00000000000=
00001
[    1.448219] R13: 000055e19046b896 R14: 000055e1cef3e4a0 R15: 00000000000=
00000
[    1.448893]  </TASK>
[    1.449119] ---[ end trace 0000000000000000 ]---
[    1.452539] Enabling non-boot CPUs ...
[    1.452935] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[    1.453678] smpboot: Booting Node 0 Processor 1 APIC 0x1
[    1.455531] CPU1 is up
[    1.460031] virtio_blk virtio1: 2/0/0 default/read/poll queues
[    1.465246] OOM killer enabled.
[    1.465580] Restarting tasks ... done.



--=-ylLSHkP05cW/RuTahjc4
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMTI1MjA0NjU2WjAvBgkqhkiG9w0BCQQxIgQg5ZThRLEN
0O2yRQJ+iMeF43vkgyBrwguMrFF3pJHDgB4wgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBvCoWNpsI1+OX9dvZIO1hqvxEPM64cakks
5tz6pnfzjiEAal2svJPg1oTlbjcoJIkIdPZq1hsG5Kdfr0srkUIzl4Fu8Eygxgqa0YlJASTFNcNw
bEX2EuBw9Atw+iDqMM0w/VBk9hkyfuHQI/HG6GpJzjt84rE5Z3Ab5ih5xM6+YAfHn0pVPJfkMzsH
Cl6u+pVphH8BFqvDnV59M4VS7f/Feo5BtW2tRVJJu5LVQC6erBzOskYDR1Ury1bDfx96S2RS/mrS
wefwioR/wDA60WABIHo9ppI+l96wpsIh3mGHQb17Fd0PUlFETEmHcsKaEGXkRW0T7/dT+hKmaytA
iB0ihaCxVlPD/+SCHYyR+P7olH5ksjTxOjGiCe9HZYriWDS9Nywid1cko/Xi/AoMcQoOcucjyjAV
3qjJR58f9Vbi6kZN33/+IthoCQVZyZP03Nh780FvX1HBfA6SbFP5v+ln9/WoMT+skRBE4Vo22Vdz
iGWYaICnL1Y/qgRp0V69IeV6tmEqlpPRqeMrvbP6ovzdswsH7GRSPyag3jpaNqOH19Jf/Yp2DgQe
ujzX4e3mZybcTuO1F/8qn2uNpG6B1ynhc6TmZlX4bM2s88rBRpUaoF6FlmG4xf8m+BgDwJthxPPL
u29qqgfr4kF0FpO/pyZ/MAqb2vI6KL6LEo103nUxRAAAAAAAAA==


--=-ylLSHkP05cW/RuTahjc4--

