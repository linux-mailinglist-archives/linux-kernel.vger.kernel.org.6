Return-Path: <linux-kernel+bounces-340657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F291B987655
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B52628137D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630112F59C;
	Thu, 26 Sep 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onrJ5hk9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C764A48
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363868; cv=none; b=uOy001Nyl8QpmjuIhDrYEiGS8c3HVoicuXLb2rMPgRtcIbt6neXjhtuPvYOGFmd8rfOUNWLtGCvunuZMcOZNHKkL1lfcMp7tr1WWACvKblutUhR8SjkjcdaD29wTDAUHwpIG2+yPD9pPbVxCIHPZh58JtRX30zQJbI/M9USSeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363868; c=relaxed/simple;
	bh=LaxbMX57JOABhNt+wtR9SoMo6PAZIGsAsQtMSeo6TTs=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=S8W3VGXYZh2MCeJrHbPhwHk7Ecm5cEwl+yu2lHO6RvrZcksdNULXUGMg2GNmTj0BNPk2dvOZhJzx//7enKo2W7i6ueNB0N21MxC7GdKbu6OOLK6f+vdYPZbavnWcufLZrJ193aarmfpwMiKqdnMzaAlE5smFLtlgr3xrySvvymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=onrJ5hk9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:To:From:
	Subject:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Nia+OUX0qy+yx2V264DJWa7wgsDL4CrFrkYRIny461c=; b=onrJ5hk9XMuACjD0r28RlNBf6O
	mYeypVliNhlGuR9jAy21uD+8dffpI4Zh9bGbnKFZMCcB3eAH7W/BxqMYsmRJCbcxxvALb2QggGmH7
	T8cR+tKH34OuRJCmeqs0qvw4GcYX8dSytNuPQhTqjjRFZouwIIzthBMUPgBI5ykTjYn8EfSH7hrFG
	uGutihnMZc7yHmxDvI4aGXjKgcP4iC00CJviPOb4+epgyGt5UUlWNcCLJgws1/nxbGDp0zCa05VQK
	Xm/XnazBpTBkiy8hiLkSsMhCZgEoHwRQhS+ZsbtMYC7SGFSJ/bbZANn8S++Z3hTpyC170Y+pVD5dr
	7FefPwmg==;
Received: from [2001:8b0:10b:5:16cf:fc6a:25d9:f696] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1stqFN-00000006wGM-0g9W;
	Thu, 26 Sep 2024 15:17:38 +0000
Message-ID: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>
Subject: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>,
 linux-kernel@vger.kernel.org
Date: Thu, 26 Sep 2024 16:17:37 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RUEQhMPLCs6nEnWVLduc"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-RUEQhMPLCs6nEnWVLduc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Add a function to check that an offline CPU has left the tracing
infrastructure in a sane state.

Commit 9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in
acpi_idle_play_dead()") fixed an issue where the acpi_idle_play_dead()
function called safe_halt() instead of raw_safe_halt(), which had the
side-effect of setting the hardirqs_enabled flag for the offline CPU.

On x86 this triggered warnings from lockdep_assert_irqs_disabled() when
the CPU was brought back online again later. These warnings were too
early for the exception to be handled correctly.

So lockdep turned a perfectly harmless bug into a system crash with a
triple-fault.

Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
print the events leading up to it, and correct it so that the CPU can
come online again correctly. Re-introducing the original bug now merely
results in this warning instead:

[   61.556652] smpboot: CPU 1 is now offline
[   61.556769] CPU 1 left hardirqs enabled!
[   61.556915] irq event stamp: 128149
[   61.556965] hardirqs last  enabled at (128149): [<ffffffff81720a36>] acp=
i_idle_play_dead+0x46/0x70
[   61.557055] hardirqs last disabled at (128148): [<ffffffff81124d50>] do_=
idle+0x90/0xe0
[   61.557117] softirqs last  enabled at (128078): [<ffffffff81cec74c>] __d=
o_softirq+0x31c/0x423
[   61.557199] softirqs last disabled at (128065): [<ffffffff810baae1>] __i=
rq_exit_rcu+0x91/0x100

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 v2: Update commit message to reflect the fact that the original bug
     fix is now merged as commit 9bb69ba4c177.


 include/linux/irqflags.h |  6 ++++++
 kernel/cpu.c             |  1 +
 kernel/locking/lockdep.c | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fde53..57b074e0cfbb 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -18,6 +18,8 @@
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
=20
+struct task_struct;
+
 /* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
   extern void lockdep_softirqs_on(unsigned long ip);
@@ -25,12 +27,16 @@
   extern void lockdep_hardirqs_on_prepare(void);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
+  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
+				       struct task_struct *idle);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on_prepare(void) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
+  static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
+					      struct task_struct *idle) {}
 #endif
=20
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00..c4aaf73dec9e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1338,6 +1338,7 @@ static int takedown_cpu(unsigned int cpu)
=20
 	cpuhp_bp_sync_dead(cpu);
=20
+	lockdep_cleanup_dead_cpu(cpu, idle_thread_get(cpu));
 	tick_cleanup_dead_cpu(cpu);
=20
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7963deac33c3..42b07c3b8862 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4583,6 +4583,30 @@ void lockdep_softirqs_off(unsigned long ip)
 		debug_atomic_inc(redundant_softirqs_off);
 }
=20
+/**
+ * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stopped
+ *
+ * @cpu: index of offlined CPU
+ * @idle: task pointer for offlined CPU's idle thread
+ *
+ * Invoked after the CPU is dead. Ensures that the tracing infrastructure
+ * is left in a suitable state for the CPU to be subsequently brought
+ * online again.
+ */
+void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle)
+{
+	if (unlikely(!debug_locks))
+		return;
+
+	if (unlikely(per_cpu(hardirqs_enabled, cpu))) {
+		pr_warn("CPU %u left hardirqs enabled!", cpu);
+		if (idle)
+			print_irqtrace_events(idle);
+		/* Clean it up for when the CPU comes online again. */
+		per_cpu(hardirqs_enabled, cpu) =3D 0;
+	}
+}
+
 static int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
--=20
2.44.0



--=-RUEQhMPLCs6nEnWVLduc
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwOTI2MTUxNzM3WjAvBgkqhkiG9w0BCQQxIgQgLMkzSay6
ZMqLWhakxeGjBo7ii66pB3Yl50vX4QfCVOAwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBKNHGB/yxtyEyiUUdJl+t6+0jRHu6g3tOA
EfhQnKmbe74+P51co3i+SwqSqY/5FTnLOF3K6RGUc9PbITzkkJlivFv9gA8+B8EtcNwGv7Q6m47y
VDzeLghve7wuJJrMv/yZK0iM4ipHZC5y5PauMquxxwrNch8qZ3D451JtpWgECkNjEy2C7J3g3RxF
pkIna61hhG2eSUlTghSdyLzJOeDlK3S7JijQxyiSeqKAhVv0ZbRM5Ug43lpAV/ax3QoT3SZ4Zv37
X8BjIfxrXV8LE7qiqwf3h+hJ0Ti7UePy7lVaDpu76aZTdlulFu8O+m1nnQ0zlVubm+/ymED4BLEf
qcVym5KyE1V4vO25MPsV6LnMMEt9SaG0odVA4N/CJylcvKvuZ82Ijg10I4jew6JVG5Q73/t1KDmy
MM3zYC2CjUVb/FeYw9djtS2/17e2zNg9yOF1jZKPu2LdPzRHLYYnmE33KBt78CYq1t0JdP9W3PBQ
rjYPQfL/zLZqy4rcVthTHGJ3FUSYEr3RqoCSokk0mbYGo2Yyjz/aTupCOn6md7iHddHNBNbSNdv+
0/N/9KeO6OcNElYx1hkSXbXIJ0syN6N1bzUjC5kIcmW2zqxo2WEA3v5ySepnfulY5esrW3UWb4xf
U+IswZ0O7HuAptF9ZxbKSbge0H5X358Nr9vlXF1V4gAAAAAAAA==


--=-RUEQhMPLCs6nEnWVLduc--

