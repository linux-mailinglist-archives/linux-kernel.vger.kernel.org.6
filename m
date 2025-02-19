Return-Path: <linux-kernel+bounces-521480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BCA3BDED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF517A718E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4DD1DFE20;
	Wed, 19 Feb 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="qVHyffJz"
Received: from enterprise02.smtp.diehl.com (enterprise02.smtp.diehl.com [193.201.238.220])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D411DE89D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967744; cv=none; b=YWR3+0xjufz3Pu+H3+tm8LiwiHu/Ubh6x1e8uxWi/Zf89LhD7CwyLSJwxV1F2zI9o199SyaHkkh/ES8E98ix8GYNqtYanL8PAoIV3j+aje7liMvCuLwe0t4Kj79zMZEAki0xhkPvveW9sXK9wOwGQn/nnbVOSZBxSFmsJUEAZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967744; c=relaxed/simple;
	bh=sQ6f5ZuZT88TlsTgt7Ids+jSBkTrGPdfm86KNPBtfc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dY2Yx/WQ53MLQRkBh9rSbqpSTXv9rTgUkEso8ifRkLNXOgU+rq5pXd5FxsBqOgBRrCqBRYpK/fct49THKPGrXTSCH7OPq9sF+GqgtsM0D2o4hlWnNaAVNnq9f6r6ITJ7utBSsVpgCE3RLtxcC/9Jccg/RA5YZneaj1ioPQJdv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=qVHyffJz; arc=none smtp.client-ip=193.201.238.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1739967740; x=1771503740;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=fPfm6YtdtGBrms8oXe5HOv6LqTtIKh++Grc3Gbt9ZHQ=;
  b=qVHyffJzdZiWz97rnzNnK9uw68jZa3j0JAPSGWnNQvCa2rPDef5iowq7
   /2MwLZzi+GQjxSsJIxdBjRdA196L1k74TNhwm/502Fp8dHdlo6llkb2mf
   sFjeZb0e2Di1bSEXg/Am2S2elRa2ytH1liCxgDTnWocKrUOPy/f3I83oT
   9rIKdbF92szVAV/vavwTkzugF3Eki7iNiY2bBjgilOxsYyqbnKANxQ82f
   Rjc8mAUOVK2qFsYDFU/BTvOId17K1k4CJPyh26R9h395a/WCws75oGHdI
   qbEQYxgvLAj+LmpfMorodo01rttveQQgn4VaoqtdaRF/UClG3LBA6igXc
   Q==;
X-CSE-ConnectionGUID: l1D829u6RtWqixt6FteiHA==
X-CSE-MsgGUID: YBrJQlbYRp61risP471X1A==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:IHEWwa3P3QmuIc1TWvbD5fxxkn2cJEfYwER7XKvMYbSIpGtil2len
 TNbADbYJbeXIjmmON5rK9ThqxtC/NSA/mJROEEx9HRgCWoVsqIpbvzIIkqpZXicd8SfHB5s4
 c4QO4SbcM5pEHbWrR6nObO8/Sgt3v7XG7GgBrOZM30qG147Qikr0E0zlrZh3NMwi4S1a+/hk
 drqu8neM1a52jlydXoX4Lnc7Qhus/L7pC4CszTSQNgS1LOJvyJEVMJ3ydiNB3vkXpEGWam5S
 vfYir2482PduRwqD5SuiLK8bk5PQonUewOUjiI+Z0TZufQxm8BI+v59bJIhQUdLly3b2Jdyx
 cRW85CxRActeKbLnaMWSR0fDyI7PZpAvrTdJSDi8o3Lp3EqCEAAsMiCdmlue9Vwx853HX1Wp
 7tfNy8SKByCiuKyhrm8T650hcVkdKHX0PgkVgJdIUvxVbB+Ka3+fpgmxeO0/R9hi5tHTK/Qa
 ZFHMjNhYEnMPUQQZVlMV8g1wr7x3neiImEB+AOeqJRs7jmIxmSd8lRP3Pn9J4bWH5UFxi50g
 kqcogwV1zlDbIT3JQKtqyzq3qmX23umBOr+LZXgntZymlqf22cPPxMfUFq/sJGRh1W3Mz5lA
 xV8FhEG8+5rryRHcvGnB0fl+CTd70ZHMzZtO7ZSBD+lm/O8DzmxVjBsog5pMLQOqMIwTDo24
 V6F9/uBLSBvqrCcVUWG/b6Sqz6oUQBNRYPVTXZZJeety4CLTLAb1nojfP46eEKGpoSd9QXL/
 ty/hHNWa4P/LyI8//7TEVjv21pAr3VSJ+I/zl2/smmNtmuVaGM5DmABBJeyAftode6kole9U
 Hcsn5GyvLpfEM+3iBOUQfURQp+16velGWiJ6bJvN8FJGzWF93uxdo9PuGs4L0BzKoAIeDLpZ
 AnYvgY5CJ17ZSPsPfUxOtL3Up9wpUTjPY2NuvT8YtdIY4M3cxSb8TtqbEic92zsnUgo16o4P
 P93dO71VSlBUfk5kmreq+E14JUx5Bk6z1LpXc6i1RW86ebBPU7MYOJQWLeJRqVjhE+emy3a8
 tFaOteWyj1SVuvzby/R/MgYKlViBXw6A43m7s9abOiOJiJ4F2w7Tfzc27Usf8pihas9qwvT1
 ijlHB8CjgOvwyScc21md0xeVV8mZr4nxVpTAMDmFQ/AN6QLCWp30JoiSg==
IronPort-HdrOrdr: A9a23:kxvyzKwRTiHWYc/TL91lKrPwCb1zdoMgy1knxilNoH1uA7elfq
 WV98jzuiWZtN9gYhsdcK+7Scu9qB/nmqKdy7NhW4tKJTOW3VdAdbsSibcKoAeQYxEWlNQ86U
 4IScEXZeEYa2IVsS+Q2njaLz9P+ri62ZHtoc//6ltXJDsaDJ1I3kNDNyC4Pmoefng+OaYE
X-Talos-CUID: 9a23:hiaWwmyIzIL6l1QkxVRIBgUQQ+x1KCzAkk3MHFa5GXo3ZqGYSH+5rfY=
X-Talos-MUID: 9a23:daEmYgsiy2IFKjDG5M2ntRt4Fv5s6ZWUEB5Ui5Qdg5XbbBwpEmLI
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="p7s'346?scan'346,208,346";a="107305668"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pps: add epoll support
Date: Wed, 19 Feb 2025 13:21:09 +0100 (CET)
Message-ID: <8baae1732dfc47759687e7537cac57ad@diehl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----BA6F3BB8C97D797A74B0DCB5787EABE1"

This is an S/MIME signed message

------BA6F3BB8C97D797A74B0DCB5787EABE1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Gentle ping

-----Original Message-----
From: Denis OSTERLAND-HEIM 
Sent: Monday, January 20, 2025 2:11 PM
To: 'Rodolfo Giometti' <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pps: add epoll support

This patch adds pps_context to store the per file read counter.

Signed-off-by: Denis Osterland-Heim <denis.osterland@diehl.com>
---
 drivers/pps/pps.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 25d47907db17..b5834c592e2a 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -21,6 +21,12 @@
 
 #include "kc.h"
 
+struct pps_context {
+	struct pps_device *pps;
+	unsigned int ev;
+};
+
+
 /*
  * Local variables
  */
@@ -37,17 +43,19 @@ static DEFINE_IDR(pps_idr);
 
 static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
 {
-	struct pps_device *pps = file->private_data;
+	struct pps_context *ctx = file->private_data;
+	struct pps_device *pps = ctx->pps;
 
 	poll_wait(file, &pps->queue, wait);
 
-	return EPOLLIN | EPOLLRDNORM;
+	return (ctx->ev != pps->last_ev) ? (EPOLLIN | EPOLLRDNORM) : 0;
 }
 
 static int pps_cdev_fasync(int fd, struct file *file, int on)
 {
-	struct pps_device *pps = file->private_data;
-	return fasync_helper(fd, file, on, &pps->async_queue);
+	struct pps_context *ctx = file->private_data;
+
+	return fasync_helper(fd, file, on, &ctx->pps->async_queue);
 }
 
 static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
@@ -90,7 +98,8 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 static long pps_cdev_ioctl(struct file *file,
 		unsigned int cmd, unsigned long arg)
 {
-	struct pps_device *pps = file->private_data;
+	struct pps_context *ctx = file->private_data;
+	struct pps_device *pps = ctx->pps;
 	struct pps_kparams params;
 	void __user *uarg = (void __user *) arg;
 	int __user *iuarg = (int __user *) arg;
@@ -189,6 +198,7 @@ static long pps_cdev_ioctl(struct file *file,
 		/* Return the fetched timestamp */
 		spin_lock_irq(&pps->lock);
 
+		ctx->ev = pps->last_ev;
 		fdata.info.assert_sequence = pps->assert_sequence;
 		fdata.info.clear_sequence = pps->clear_sequence;
 		fdata.info.assert_tu = pps->assert_tu;
@@ -249,7 +259,8 @@ static long pps_cdev_ioctl(struct file *file,
 static long pps_cdev_compat_ioctl(struct file *file,
 		unsigned int cmd, unsigned long arg)
 {
-	struct pps_device *pps = file->private_data;
+	struct pps_context *ctx = file->private_data;
+	struct pps_device *pps = ctx->pps;
 	void __user *uarg = (void __user *) arg;
 
 	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
@@ -275,6 +286,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		/* Return the fetched timestamp */
 		spin_lock_irq(&pps->lock);
 
+		ctx->ev = pps->last_ev;
 		compat.info.assert_sequence = pps->assert_sequence;
 		compat.info.clear_sequence = pps->clear_sequence;
 		compat.info.current_mode = pps->current_mode;
@@ -300,7 +312,13 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
 {
 	struct pps_device *pps = container_of(inode->i_cdev,
 						struct pps_device, cdev);
-	file->private_data = pps;
+	struct pps_context *ctx = kzalloc(sizeof(struct pps_context), GFP_KERNEL);
+
+	if (unlikely(ZERO_OR_NULL_PTR(ctx)))
+		return -ENOMEM;
+	file->private_data = ctx;
+	ctx->pps = pps;
+	ctx->ev = pps->last_ev;
 	kobject_get(&pps->dev->kobj);
 	return 0;
 }
@@ -309,6 +327,7 @@ static int pps_cdev_release(struct inode *inode, struct file *file)
 {
 	struct pps_device *pps = container_of(inode->i_cdev,
 						struct pps_device, cdev);
+	kfree(file->private_data);
 	kobject_put(&pps->dev->kobj);
 	return 0;
 }
-- 
2.45.2

------BA6F3BB8C97D797A74B0DCB5787EABE1
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIPQAYJKoZIhvcNAQcCoIIPMTCCDy0CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggxWMIIGUTCCBDmgAwIBAgICMAAwDQYJKoZIhvcNAQELBQAwgaMx
ITAfBgNVBAMMGERpZWhsIEdyb3VwIE1haWwgUm9vdCBDQTELMAkGA1UEBhMCREUx
EjAQBgNVBAcMCU51ZXJuYmVyZzEUMBIGA1UECgwLRGllaGwgR3JvdXAxFDASBgNV
BAsMC0RpZWhsIEdyb3VwMQ8wDQYDVQQIDAZCYXllcm4xIDAeBgkqhkiG9w0BCQEW
EXg1MDktY2FAZGllaGwuY29tMB4XDTE4MDUyOTEyMzIzNVoXDTI4MDUyNjEyMzIz
NVowgZQxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xFDASBgNVBAoMC0Rp
ZWhsIEdyb3VwMRswGQYDVQQLDBJEaWVobCBNZXRlcmluZyBUS0gxHzAdBgNVBAMM
FkRpZWhsIE1ldGVyaW5nIE1haWwgQ0ExIDAeBgkqhkiG9w0BCQEWEXg1MDktY2FA
ZGllaGwuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtISPrKPL
Zjjh//2n9b+GXgrhijJV2knQVC0+/FS3zGl4p2fboB+Vr4YHz1uilEvhsS1oG4FV
f1u0dqdmLVxDHBPMO2K1NKKOJN/6LDDfyiZGNqDOJke6FzrmDyPXXTDtgzWZfdnD
esx63XSxprre30oJ3BxDFS+/8UpuI628SPc1N4125rHeUXG4scKFSjqRPcIOAQ2X
veGXU2dYHzq7B02NA8tssmtJNwXjyvMjOw6HGZ8SB87TrFQm6drEtM7QhI/mfpGe
nTZ4nc84n0yKuMveav8IOspYbkOXzi4JapiOUpmccNLZdIiMg5WJQ0Xt9NSp5yD5
CYKideGrWgX2wNEBpalgjZoPPQDImcWEJx88/yYZ4FwtRD3VueFqpBr4z/bxwVDr
N2a/sEqnocY9Tm2EQyHFHDCJ9JyYEXB8W0LTFcUAx+uHijwPk/oIB5EeH8UygXlX
qUqII+BUZ+q5m5sIc4eXQ10UpUEjG/ptIyO1Ee/E0kPOWzHp07pPgXCZohZb3y41
Ha2pO6rXOsOmPBK2r2++fLWz3NFyfEJCmn6FcBNi003HUEVCup1D9/9yaPHPSieN
27sjQcQ96GbOitC99p3xMnSlg4N11lGeuTXCZjIGXdZL5/dThQaxneVA+hr2X+i1
KmqnesMaSBEuBEBDmbDbakEgJFVWtVeXuk8CAwEAAaOBmzCBmDASBgNVHRMBAf8E
CDAGAQH/AgEAMAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUn8t6NGPzWsF+oZYXxmfn
p4Ok7rIwHwYDVR0jBBgwFoAUZrrYQMMD50v/OCDMgDN7y/GT2P8wNQYDVR0fBC4w
LDAqoCigJoYkaHR0cDovL2tleXMuZGllaGwuY29tL2NybC90ay1oX24uY3JsMA0G
CSqGSIb3DQEBCwUAA4ICAQAl6hO6b6+GseZi3EAU+zPVhxNZP5Y+YsBnjf13jCGw
nUVvPz6giwXiCd9KIC4eCqqrJLTHwZe8c/9hSk5CCd6A5XAd3YudrPDvmIwms5Ex
OREMQkygZO6/qxfXO6IhfUO4HvYQtQexzHOLuxG/KdycVwWapA4acFzBurxFQ3aG
jvPRgvWxe2Mt3K9wLrEhvGrDmS8yg4bYNyBZGgax6LRhfW4/ShInVUa0koG2Sj+H
hKpppvqDK4FNgR2dKeCPoo28P9a+K9N3wkLKx4zxaxHegij0DsJOBAVbhk+vDWDO
gedjtT09c9bsykaXFzykyQeQz7cwrTQ1gDacdcDgywMDQzZKim9O3JpyzvXnD7mb
CvclM3xp9w6jIJbeaQE7HDlA9YIL/bSRIQq8mJcXArUevLK2MX/Mb+5m3UMU+zXc
ZqmaneeZeR4bOWrmmhK6bMuce6H+i2YB1vG3BAcSfKQUzZ1m6aKSW1FvjI3SZXQD
FzRzBwC5ql7i2ugtfOLNYjOO/fvAxNppIZb3IyWN1KBAI7YgS4nx0us/NIlWpTMW
91WeUtNBCp2sgi3VTi/TUel3RZ9x3tggMUhrksGkFXz2NUL85AdPV6BqJXXXHggd
121rnduE9ocMt0MFLuDPkMaHqKNzBAcKTcmFM8KYMJ5Z7NBqGtTAgHNVmEnU8gu3
czCCBf0wggPloAMCAQICAgtcMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJE
RTEPMA0GA1UECAwGQmF5ZXJuMRQwEgYDVQQKDAtEaWVobCBHcm91cDEbMBkGA1UE
CwwSRGllaGwgTWV0ZXJpbmcgVEtIMR8wHQYDVQQDDBZEaWVobCBNZXRlcmluZyBN
YWlsIENBMSAwHgYJKoZIhvcNAQkBFhF4NTA5LWNhQGRpZWhsLmNvbTAeFw0yNDAx
MDIwOTE5MzlaFw0yNjAxMDIwOTE5MzlaMIG8MSIwIAYDVQQDDBlkZW5pcy5vc3Rl
cmxhbmRAZGllaGwuY29tMSgwJgYJKoZIhvcNAQkBFhlkZW5pcy5vc3RlcmxhbmRA
ZGllaGwuY29tMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMRwwGgYDVQQK
DBNEaWVobCBNZXRlcmluZyBUSy1IMRwwGgYDVQQLDBNEaWVobCBNZXRlcmluZyBU
Sy1IMRIwEAYDVQQHDAlOdWVybmJlcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDC4CfZJns8lrNXSkis30SmXgEPwIED4unjF8EoHzBRk5cQphMwuxVY
uFrZmkB8+FJ7kNnazQ5ddAH+7uh/w7vxEbch92iEpJxYRT6z9U7Mgw0sqGjzWQjd
sVzCSrWJrOdrHXc65BnAPOpjNDNe1dR8J9Z4a7OZU5NnQqJMT314j2gfGawGDakJ
Vph7S6v4AVmty1Fi4iRbaIamu8KJFrHQb5E1UVD5drrxW6TS0z/3YkrMQ6qA1fBB
Y271mRVq/1ByvJMgPJu7LtIyuGwGJw44RxF0JPLlqRWpsIa+z2cI48dkvwb8k0T1
rNSIj9urOmUEJGF5O8LioUy0vwmxeWF7AgMBAAGjggEtMIIBKTAfBgNVHSMEGDAW
gBSfy3o0Y/NawX6hlhfGZ+eng6TusjAJBgNVHRIEAjAAMCQGA1UdEQQdMBuBGWRl
bmlzLm9zdGVybGFuZEBkaWVobC5jb20wNQYDVR0fBC4wLDAqoCigJoYkaHR0cDov
L2tleXMuZGllaGwuY29tL2NybC90ay1oX24uY3JsMDUGCCsGAQUFBwEBBCkwJzAl
BggrBgEFBQcwAoYZaHR0cDovL3d3dy5kaWVobC5jb20vcGtpLzAJBgNVHRMEAjAA
MB0GA1UdDgQWBBQK9y4jVYoCDsL7lhhJKjEP5wv1nTALBgNVHQ8EBAMCBaAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGCWCGSAGG+EIBAQQEAwIFoDAN
BgkqhkiG9w0BAQsFAAOCAgEAB27J8TZvm6g0rtQpv4kqYwzkXOkCt27WHHWzl/JZ
knFwWH4mvlRSrQtKkx8cPb5xqqx7k4qXC7TAef4W5YmnpWDtw7YHQAygAsCV1+i8
uBhdnBVRYkLi0Brsqb/KaDVCFDAYn82kr8OlDaVl5GazIF5rTTUFVT7QEUewf5e7
Ej4tkepIMP8DW0mM9VRdiSd+DFQQQsQR91nJZS+Gd0jT2tW6SVtZEGnsdgKi9VOw
+/u7TPynQA3m70zel9t0RySfc5bfZGqEBK/nqU2g5n/qaHKT9cMM8vTAJOmzMv4W
p7j6RF851h+6c4kH0UsUR9LdbXsKS0KsKTmjPbmbuMAWSEafskq5lJdhIybBnGcp
FwOkXw6yLHhvmBQ27hVolbrAgLprlLBm8qLq0G3dPHlLwgnNlD6RAcjaVLOcqH3Q
HWHbKlVg310S75cll1rM+GAudWdsHWxOUbK7R0lwJf/E+FAXciAsExWzCQarpSFI
AYJjvnsYTiSWas6b5L/rKtyeWIz5wJ3ovxFaMglCtGNGh3sqKwVgb0PeGJ/hfXkV
Z3i06A/GFOMDvvZ4kI2OL2wwUftkvi8ID5g2nbX/WQh9y6zhlXtiOlA1IplU+PU3
OHrFL4SBW0X7j1l+9Jl9kGy/ukAr+9nWZ55nUoV/L9C1GLrAO5KF/fDpO2b7lidQ
mWUxggKuMIICqgIBATCBmzCBlDELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVy
bjEUMBIGA1UECgwLRGllaGwgR3JvdXAxGzAZBgNVBAsMEkRpZWhsIE1ldGVyaW5n
IFRLSDEfMB0GA1UEAwwWRGllaGwgTWV0ZXJpbmcgTWFpbCBDQTEgMB4GCSqGSIb3
DQEJARYReDUwOS1jYUBkaWVobC5jb20CAgtcMA0GCWCGSAFlAwQCAQUAoIHkMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxOTEy
MjEwOVowLwYJKoZIhvcNAQkEMSIEILgnT7w842LRot/3+5pWzm5njK2yrEoJdr3L
hfRXe3DlMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUA
BIIBAJmazwV6+AUS0fQiOEE22tbebUEUtaYaruNAJe2s+dKcXVYN0lBJ2ei3hXVA
XTfakRQwew08OI3du5bHjpBgIGxgQa9n9qEP8YhZkXcQlO9bna+KsOIaH203Nlrz
MLaAbi4prPbu6qXN7KDbc8Nw4DxCqcTSCYpmlmeZ9diWM+u7H3Hr7UbhfhWI6EY8
2bWvJfqwAwQsJ1ssTFh0cXv0cpOjqWIpJf1DiTAhUhxiTwJRanEsNnDaIEuXzPYu
pkxvI04XtghTIQo4sO7APIzBrTUC1zodivOrE89+zW3zJlnspneCm9ANgBvY/ioc
ZsSN7eADB/CPHfEsn2ohTWMEdCY=

------BA6F3BB8C97D797A74B0DCB5787EABE1--


