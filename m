Return-Path: <linux-kernel+bounces-337243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBB984780
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7524028469B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E311AAE00;
	Tue, 24 Sep 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJ3rBLLR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B513342F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187622; cv=none; b=Egh182uTAWIEC7Q/N1F0ivq1IzjAg4wlgGBbzJ1N+TDCrMz6aE3dDFsTbCzS7CQ/Z5QMyBFT5TKOCw76vzEs3pt3Iazzs/lCn49SGqQPb3Z6PHZB02a9eFuWYFI1rIOVZ2b+4Ap1HBxlakZ3HKZARtXj9zqjrmcsMBJX0hENs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187622; c=relaxed/simple;
	bh=ufaWffakHOsf4DisdIts6tLw7IGRWRxoWiVwl+DB1Kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KECr0NFiJrmlRAU5+wTXHA4LJP74efXUp2dGA4GbtEv9Mt1/sjoZy8xPaQvagdiWIG8BOYmZlBFWK0nhMc+7dMmxHqXvCtsFWmKlrtg34PLq/CMsjxblKGI/b95DiAf0wTHLVG9e49cjqWbEyy5rY/ah1UdpPJ9sa9CvO2va5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HJ3rBLLR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ufaWffakHOsf4DisdIts6tLw7IGRWRxoWiVwl+DB1Kw=; b=HJ3rBLLRK6qF0oPX2pkTq0vyCS
	RpeY7sAuYoEUTywvKQL88L2VxdQZ+2elRmcuAJEBVqL0IBbZny0GnGDTSOX25ZlVSVQLhQU6yFWVq
	Gpc4qKnqjj9tzGPueQ9ZGYBzEGaUujXjesOfxGrxOpISnYEgBU8zVWdgZW8xnxAOj2hktxGU2SOh/
	rLmX0Kpk3zFmw068H2NiJphAp750Fux3jCv4Ai+hrfKqdW826i//JR7NL572as6jjmGQpYu+mfz6d
	KGmM2oo9KFOoBtZlx4TD3k3O1NL6CD9QK+BLkLMjy3X4kUDDcUC4r3HMtfT1hbYToEyZPYEH/3VvO
	TvIOcebQ==;
Received: from [2001:8b0:10b:5:58f5:7dd9:39e2:1ee3] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st6Ob-00000001i9E-2p6c;
	Tue, 24 Sep 2024 14:20:06 +0000
Message-ID: <1da59ef5df8e8a2bebd31535fa13264113a316ff.camel@infradead.org>
Subject: Re: [PATCH v3] lockdep: add lockdep_cleanup_dead_cpu()
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Date: Tue, 24 Sep 2024 15:20:05 +0100
In-Reply-To: <2b8c36376fa01fa6a1bac9570eb7d41e7e232a29.camel@infradead.org>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
	 <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
	 <2b8c36376fa01fa6a1bac9570eb7d41e7e232a29.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-3M3NB8rBJlVTUF79ZMwX"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-3M3NB8rBJlVTUF79ZMwX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-10-30 at 08:45 +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Add a function to check that an offline CPU left the tracing infrastructu=
re
> in a sane state. The acpi_idle_play_dead() function was recently observed=
=C2=B9
> calling safe_halt() instead of raw_safe_halt(), which had the side-effect
> of setting the hardirqs_enabled flag for the offline CPU. On x86 this
> triggered lockdep warnings when the CPU came back online, but too early
> for the exception to be handled correctly, leading to a triple-fault.
>=20
> Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
> print the events leading up to it, and correct it so that the CPU can
> come online again correctly.
>=20
> [=C2=A0=C2=A0 61.556652] smpboot: CPU 1 is now offline
> [=C2=A0=C2=A0 61.556769] CPU 1 left hardirqs enabled!
> [=C2=A0=C2=A0 61.556915] irq event stamp: 128149
> [=C2=A0=C2=A0 61.556965] hardirqs last=C2=A0 enabled at (128149): [<fffff=
fff81720a36>] acpi_idle_play_dead+0x46/0x70
> [=C2=A0=C2=A0 61.557055] hardirqs last disabled at (128148): [<ffffffff81=
124d50>] do_idle+0x90/0xe0
> [=C2=A0=C2=A0 61.557117] softirqs last=C2=A0 enabled at (128078): [<fffff=
fff81cec74c>] __do_softirq+0x31c/0x423
> [=C2=A0=C2=A0 61.557199] softirqs last disabled at (128065): [<ffffffff81=
0baae1>] __irq_exit_rcu+0x91/0x100
>=20
> =C2=B9 https://lore.kernel.org/lkml/a079bba5a0e47d6534b307553fc3772d26ce9=
11b.camel@infradead.org/
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>=20

Ping? Found this lying around in a branch today...


> v3: Add forward declaration of struct task_struct.
>=20
> v2: Fix spelling. 'Offlone' wasn't quite what I meant to type.
> =C2=A0=C2=A0=C2=A0 Add reference to ACPI patch.
> =C2=A0=C2=A0=C2=A0 Fix kerneldoc args for lockdep_cleanup_dead_cpu() (tha=
nks lkp)
> =C2=A0=C2=A0=C2=A0 Closes: https://lore.kernel.org/oe-kbuild-all/20231029=
0041.L5ndwcQ9-lkp@intel.com/
>=20
> =C2=A0include/linux/irqflags.h |=C2=A0 6 ++++++
> =C2=A0kernel/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/locking/lockdep.c | 24 ++++++++++++++++++++++++
> =C2=A03 files changed, 31 insertions(+)
>=20
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 2b665c32f5fe..9b44f8b042a0 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -17,6 +17,8 @@
> =C2=A0#include <asm/irqflags.h>
> =C2=A0#include <asm/percpu.h>
> =C2=A0
> +struct task_struct;
> +
> =C2=A0/* Currently lockdep_softirqs_on/off is used only by lockdep */
> =C2=A0#ifdef CONFIG_PROVE_LOCKING
> =C2=A0=C2=A0 extern void lockdep_softirqs_on(unsigned long ip);
> @@ -24,12 +26,16 @@
> =C2=A0=C2=A0 extern void lockdep_hardirqs_on_prepare(void);
> =C2=A0=C2=A0 extern void lockdep_hardirqs_on(unsigned long ip);
> =C2=A0=C2=A0 extern void lockdep_hardirqs_off(unsigned long ip);
> +=C2=A0 extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct task_struct *idle);
> =C2=A0#else
> =C2=A0=C2=A0 static inline void lockdep_softirqs_on(unsigned long ip) { }
> =C2=A0=C2=A0 static inline void lockdep_softirqs_off(unsigned long ip) { =
}
> =C2=A0=C2=A0 static inline void lockdep_hardirqs_on_prepare(void) { }
> =C2=A0=C2=A0 static inline void lockdep_hardirqs_on(unsigned long ip) { }
> =C2=A0=C2=A0 static inline void lockdep_hardirqs_off(unsigned long ip) { =
}
> +=C2=A0 static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct task_struct *idle) {}
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6de7c6bb74ee..225f5bc3708f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1371,6 +1371,7 @@ static int takedown_cpu(unsigned int cpu)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpuhp_bp_sync_dead(cpu);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lockdep_cleanup_dead_cpu(cpu, =
idle_thread_get(cpu));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tick_cleanup_dead_cpu(cpu=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcutree_migrate_callbacks=
(cpu);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e85b5ad3e206..62bfda8991b8 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4538,6 +4538,30 @@ void lockdep_softirqs_off(unsigned long ip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0debug_atomic_inc(redundant_softirqs_off);
> =C2=A0}
> =C2=A0
> +/**
> + * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stoppe=
d
> + *
> + * @cpu: index of offlined CPU
> + * @idle: task pointer for offlined CPU's idle thread
> + *
> + * Invoked after the CPU is dead. Ensures that the tracing infrastructur=
e
> + * is left in a suitable state for the CPU to be subsequently brought
> + * online again.
> + */
> +void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle=
)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(!debug_locks))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(per_cpu(hardirqs_=
enabled, cpu))) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pr_warn("CPU %u left hardirqs enabled!", cpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (idle)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0print_irq=
trace_events(idle);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* Clean it up for when the CPU comes online again. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0per_cpu(hardirqs_enabled, cpu) =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +}
> +
> =C2=A0static int
> =C2=A0mark_usage(struct task_struct *curr, struct held_lock *hlock, int c=
heck)
> =C2=A0{


--=-3M3NB8rBJlVTUF79ZMwX
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwOTI0MTQyMDA1WjAvBgkqhkiG9w0BCQQxIgQgKn/zSCEO
17oGXUJU6+Dx3WHAALK8NVPqaNDugJxJwpYwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCd4Bc0go2ADTHbWjmUsWykad6ZM/mkULwT
fTwg3i/vwOBrrOm8g+OtAiDSXHTx7IysThCL1eVOi9xYTgJwcIUef9IxkzxJbEQlOUSLo/v4OPPT
GXsktvxvvGX0KmgIbEPHBOQvxLN7CqgkvhHuf+9p4bEphSeEPvHz6hecxVIEqOgg3TB2Kd8Dwf0J
nb2EgMfsvs3a2AJd7RfHn48rYREC2B2p2GCut/wzdDu9Hkh8OGowFVNJGfvBPztp4brYVlpIlh5J
p7IqPGOYDbToLB5FDpepRPq05iT/PLWjLLTHbUpNV+3SlWW1VNwo7woztJXik44G610b6Q2n/Awt
IQl4Mx9SbfWq1MZjqiZkik6hxXHCI3LQRnHpbFTm22QDiMPSmh2BWnU4ALTD8whmTdx4GNK8yiwy
RPzcRPIBxcZMeuXLtu5M19zTHJ1vx7qNVj+WgR6QRWqrI1x43HQkgBNA6vEnbyq7ITVFKxHZ0/ht
fWS4PYjbHs+RVKqMxVwoRWBgEJB1k2ZvhHzuGBPbIHkB51lfRMSLhH8VkHja9QXZtUMXWAh1Eo/V
/yiM+uw5clhPEiu9Ism9Z22LHXp5E36dRg8sRr5/9nRMitnAxTXaSH9TpJt8wmquGIj6NE2CZ1U/
JSSmp8r0NvJulrD7CQFdo2Z89JrUsZwwWLNwImx22gAAAAAAAA==


--=-3M3NB8rBJlVTUF79ZMwX--

