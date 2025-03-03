Return-Path: <linux-kernel+bounces-544974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB2A4E782
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E0C460673
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566420A5D6;
	Tue,  4 Mar 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="SDBt0OKu"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947C27CB09
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105950; cv=pass; b=oNlqNsJCA7pJOFjgFP/1YoOLdFLFuO+W2bJbxNhs2RWjS2FARX3aw1EDB9s6Vzky9SYEiwDDowkGC2GCORM13j9H2dSuyqgIM2Y4WTsDNkqgwqFhzI/dTjBJQZy8EfuTA4F/rpwX8FrEGAgQOqOEmOk3AHBUwq58zIPMqJL0SBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105950; c=relaxed/simple;
	bh=3PZZndBPsVKBOLyQESG5q3PtS34Wdek2lLE+N2a8zhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z4sKfulyadynk504VQScb7y9XgHKe87VADlC48NVcTM/o70PUli9oWV/tT4/iITRdRX8Nq7VDcZrzJDMR3ANha6YRi5iooj+xEED1i/foi1i/A/7eGuDfotK5jxTsSwneEOLds7KfWgWapxai9ALHlTVK1RZvqdq88IHI7AYAh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=SDBt0OKu; arc=none smtp.client-ip=193.201.238.219; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 4495A40D919F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:32:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=diehl.com header.i=@diehl.com header.a=rsa-sha256 header.s=default header.b=SDBt0OKu
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h5B5d2KzG3GD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:31:10 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1C60042720; Tue,  4 Mar 2025 19:31:09 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=SDBt0OKu
X-Envelope-From: <linux-kernel+bounces-541115-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=SDBt0OKu
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D962141C73
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:03:17 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 4E2E73064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:03:17 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DAD3A7D69
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CE13FD86;
	Mon,  3 Mar 2025 08:02:35 +0000 (UTC)
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0395474C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988950; cv=none; b=DNgREFZbtCHgJbOldv4huz7hbYmg+7xKVnrloAL/CTXJKxbSb4sXWj60USRFkirSQW35rm/OdOQmM57Tic+dPnSvIJdazMW/KnFg/9YVnIzmPU9m2k9Hp1vzTFVehU2ouLmu32JyLm4pT7Z96cHrnjc28PVMbFRW091vhT0OapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988950; c=relaxed/simple;
	bh=3PZZndBPsVKBOLyQESG5q3PtS34Wdek2lLE+N2a8zhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGaFeOZ6qh7PM9E0w5NY+5MaeIGztF4BCXsIajoIb38H0c2jZOewytq+VX9RkyxHPe7AsJqXMykZfXkF9ZWu5TKIrO2u/rc4hwPjDMBBMV1SKHBGglzmkcB7ta5RMB51h6gEFj5LYxSHJn+eqcvlqjIrjXkkD/LutrfMaiDUwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=SDBt0OKu; arc=none smtp.client-ip=193.201.238.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740988947; x=1772524947;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/QaAGgYQAdsxaIinfcF5JTY1QSItdY88RHdm0QaolUs=;
  b=SDBt0OKuMFaCZVI9ZlZCsQM0x+MZ2hpM4vu1DvcunXaL09QK/FPyqyEV
   Ee6bty3g3a6g/xb2dw4fOP56eTavFfL0S2qVwGhO1tUoe1FG4soG7PZdj
   l1SfYrx65r5PZ7qjYwuv81bntYa6rJFYuHOYUBlFJkeL2rlGUftXlBqbL
   2jtKibOwXbHH7j1W54w1F4WFFn9l/TjJzmOQzUjllxnOlHO1+aDlGOCi5
   CE6E+jUoKGEFM/hz9A5BJbj5MhQGooaeGUDyUpa6Mz9vG5sXPMMS9ia6X
   KnbbUSK1kA0qHlZsGnmolRX769jaGeHarkt8RVJD/2DXYsV9F9PDh7AE4
   Q==;
X-CSE-ConnectionGUID: eukLl/R2SHScVm6BgAw/Nw==
X-CSE-MsgGUID: 94ge0bYVTJmjjht5ZFEQpQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:OX79+Koa3X+2PIOrluAQp4ci+dJeBmLcYhIvgKrLsJaIsI4StFGz/
 xJOGSnaY6zbJjuqJcY+dc3tpgkBpNWMmYgyDEcu+BmBJVpRrMvACJKBcVyY00i6dcaaEU9qt
 M9BMNKbfZxpFCaB/EvzYuO79nIhiPCDGOvwUL+aNishFQVqEH161ElukuJjjoJi2dPmUw3Us
 475qqUzVHeswyZwM2kd96OErlR3v//p53YDv1M4bOxWplK2e1w9VfrzconvdyCoKmUtIsa6W
 /rbnvb+92LQuQwyC8i+ibf0dAsBQvnbPBLL0CRfBPGp2kkH+nM/2ONnaacVLBZd0WXMw9p9l
 49Bu8ThE1clZpePwG71mzdYDz1mb+oB/7TcOT6krs2I1FbHfH2qyPUpF0A5O8of8f0yCGhF/
 vcVJG1IME6O16fqmOzqD7hm385mIsWxbYoV5SptwzzSVewbKawvOJ4mk+K0ph9rwJgmIN7ee
 9YBO30oZRXJJQZQO0wME5MxmqGjhj72cicd9FvKq/NosziWllJ7jf2xYNfeP9XXGZoQlR+Tq
 jrM8T2mCUoWbOH39db+yZ7auwO1tXi9AOovPL2k6uY4xxqY3GhVEwIXTkCgoPa/zEW+HNlTM
 wlP9ydz8KY+qAn2H4KtGkHhrXPB7kQQUZ8LSbdh4QqAxPffuV3BOwA4okV6hKobWLUeHnpyv
 mKhn8/1HW4o97aPTTSG6baPtiizNi5TJm9FbiMcCAZUvNe7/4pvyx+RFYomTKW4hZilFGv5h
 mjWpnJmjuoa1pYAiv2GlWwr+AlA0KUlNCZuoF2/Y1+Y0+9ZWGKET9H0tgOAsf0cINrFRAeI4
 SVewJjFtuoCUc6DzCDTH7hcQOj5tv2IDmbR0AVld3UDG5ZB2Fb+J9wKsGEmTKtNGpxZEdM8S
 BaL4Wu93LcKYj3yK/cxO9/tYygT5fCIPcz/UfzJZcZ5bJF0dQuWlAljfkf4M1rFySDAqolhf
 87AGSqQJSxCU/k/l2LtH751PYIDnUjS+0uCHPgX8Dz3idJyVFbNIZ8ZPV2HaPwO7a/siG397
 9ZFOsKW/A5UWev4bzO/2dZ7wYcidCVT6Tje8qS7R8bbSuZUMDhJ58z5mNvNT7dYc5F9zY8ky
 J0ftnhwkzITjVWfQemDh+sKhLnHBf6TplpjVcAg0MrBN9HOru9D4Y9GH6bbc4XL+8Ru0P1QS
 74/If6gOf9xT2rt9B0CKr/i+dkKmBSD3WpiPgKpZSo0cIE4HUrC/cX8OAfu+SkKSCGwsKPSo
 ZX5jkWLG9xaF0I7V5y+hPGHljtduVARleRzRA3POcVeYkHl9oRCJy38jvtxKMYJQfnG7mLDi
 1fLUElJ/oEhpadkrNbE3aq1kbuLFul8HlYHLUf21K6PYHyyEm2LhNUovPyzVT/cU2b55LmjT
 ehTyfzxNvsK2l1NtuJUF7dt0LJ75Nb1obJe5hprEW+NbFmxDL5kZH6c0qFnrbFEzLtUkRW5V
 1jJ/thcJKXPP9nqeGP9PyJ8NqLTj7dNyn+Ltq5dzFjG2RKbNYGvCS16VyRgQgQHRFepGOvJG
 dschfM=
IronPort-HdrOrdr: A9a23:VW0ZWqO17wQO7cBcThijsMiBIKoaSvp037BL7TELdfUxSKalfq
 +V7ZAmPHPP+VMssTQb6LK90cq7IU80l6QFh7X5VI3KNGLbUSmTXeJfBODZskTd8kPFh5Zg/J
 YlXaw7J9H5EERggdyS2njeL/8QhPeCtI6n7N2w856vd21XgmNbgjuRxjz0LqS+fmh7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3Aer8n2WjMq2ehRwYY6gmNYbJtmzJuf2De6HOXGRW?=
 =?us-ascii?q?DKV1idrjLY1C55+RCjJ87?=
X-Talos-MUID: 9a23:2Ci1cQSNkTW3r01ARXS92D5vbM1Z3ZiMDUIPkYlbieepDDRJbmI=
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="p7s'346?scan'346,208,346";a="114959693"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.linux.org" <stable@vger.linux.org>
Subject: [PATCH] pps: fix poll support
Date: Mon, 3 Mar 2025 09:02:19 +0100 (CET)
Message-ID: <561f4dfd4cbd416baee0fb39b5d55aa1@diehl.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----E086469657478513811EB6EB5AD6D117"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h5B5d2KzG3GD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710688.43847@qUJ7wwe9SWvDmW8YMzKSfA
X-ITU-MailScanner-SpamCheck: not spam

This is an S/MIME signed message

------E086469657478513811EB6EB5AD6D117
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

[BUG]
A user space program that calls select/poll get always an immediate data
ready-to-read response. As a result the intended use to wait until next
data becomes ready does not work.

User space snippet:

    struct pollfd pollfd = {
      .fd = open("/dev/pps0", O_RDONLY),
      .events = POLLIN|POLLERR,
      .revents = 0 };
    while(1) {
      poll(&pollfd, 1, 2000/*ms*/); // returns immediate, but should wait
      if(revents & EPOLLIN) { // always true
        struct pps_fdata fdata;
        memset(&fdata, 0, sizeof(memdata));
        ioctl(PPS_FETCH, &fdata); // currently fetches data at max speed
      }
    }

[CAUSE]
pps_cdev_poll() returns unconditionally EPOLLIN.

[FIX]
Remember the last fetch event counter and compare this value in
pps_cdev_poll() with most recent event counter
and return 0 if they are equal.

Signed-off-by: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
CC: stable@vger.linux.org # 5.4+
---
 drivers/pps/pps.c          | 11 +++++++++--
 include/linux/pps_kernel.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..9463232af8d2 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &pps->queue, wait);
 
+	if (pps->last_fetched_ev == pps->last_ev)
+		return 0;
+
 	return EPOLLIN | EPOLLRDNORM;
 }
 
@@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		fdata.info.assert_sequence = pps->assert_sequence;
 		fdata.info.clear_sequence = pps->clear_sequence;
 		fdata.info.assert_tu = pps->assert_tu;
@@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		compat.info.assert_sequence = pps->assert_sequence;
 		compat.info.clear_sequence = pps->clear_sequence;
 		compat.info.current_mode = pps->current_mode;
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index c7abce28ed29..aab0aebb529e 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -52,6 +52,7 @@ struct pps_device {
 	int current_mode;			/* PPS mode at event time */
 
 	unsigned int last_ev;			/* last PPS event id */
+	unsigned int last_fetched_ev;		/* last fetched PPS event id */
 	wait_queue_head_t queue;		/* PPS event queue */
 
 	unsigned int id;			/* PPS source unique ID */
-- 
2.47.2

------E086469657478513811EB6EB5AD6D117
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIXkgYJKoZIhvcNAQcCoIIXgzCCF38CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgghPaMIIGpTCCBI2gAwIBAgIUPseeE9qJ+oSdbny5LvEHTpzUCAIw
DQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2ln
biBBRzEtMCsGA1UEAxMkU3dpc3NTaWduIFJTQSBTTUlNRSBSb290IENBIDIwMjIg
LSAxMB4XDTI0MDUyODA4NDExMFoXDTM2MDUyODA4NDExMFowUjELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEsMCoGA1UEAwwjU3dpc3NTaWduIFJT
QSBTTUlNRSBNViBJQ0EgMjAyNCAtIDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQC6Dz+IfbUsaCl0cWcbnNS1BIaKrdka8ev1Kc1G6OCYH4PMtkZmC6Zo
nnh/Dl5bOuiH+pMq1fj4BSEkRYTuOGtsWelcf6UNA11KL//zh1enaaNayqqRaCSE
JTZH+JFb0UJWwO+qGVb1RfHnPXYrI6n8w1chCxL9AibzvsDPR6I37iUwiNo4p6Uo
aPNAmIncpDIGgTGodkOjjPPbGwYjg58eINT63rqMQASJxUnPPIa0gZRix0NY7A6U
z8Iv98RbbQy7ZEDvHdLFeVmzl/5TXKbQExfnEpyOjjifWoJ+FeKkEj4O9Ohd/2fg
HQ6Y+DYwLFbHZPTmDvHQoOSS//V2NBkdnGTsfIcziIH1hypFxR/hqexJ+Da7Z7uN
jBh2ligdXNHDGMeq640X2WVx0sfSZljxbeknrr3KFfzqfealPps1UI68Q+1iBLl/
Ep8aZeRmzwCK+ibAPQpKfbxsjd8cBe8FcXaOWU4DjP6YmYy0xMC4vHXr3ZgrHqL9
8D56InfiYbrBMZp1UKDSzlz/rjXWRmrXnsY5gFU705KWrJu2guSYCrc4InG3Pj+E
mPmE6Eosikk2wg90nYFxJDM/9dPJnyIw6IdkV6qdrv9h7VKrpLrl22qETWC4/Xfi
JU7YsY6HFKnpAElKu8t6rUnU5GcwgWjcB+zBfQD1Kt59jlLob2PcDwIDAQABo4IB
cDCCAWwwXAYIKwYBBQUHAQEEUDBOMEwGCCsGAQUFBzAChkBodHRwOi8vYWlhLnN3
aXNzc2lnbi5jaC9haXItNGE3ZjE3ODgtMjZiNS00OGVjLWE1NDctYzFjZDBiZjE3
YzNkMBIGA1UdEwEB/wQIMAYBAf8CAQAwQAYDVR0gBDkwNzAJBgdngQwBBQEBMAkG
B2eBDAEFAQIwCQYHZ4EMAQUBAzAIBgYEAI96AQMwCgYIYIV0AVkCAQswUQYDVR0f
BEowSDBGoESgQoZAaHR0cDovL2NybC5zd2lzc3NpZ24uY2gvY2RwLTNlZTU1ZmQ0
LTU5MzgtNDFlZS04MmRiLTMyMjNhY2VmNWMyMzATBgNVHSUEDDAKBggrBgEFBQcD
BDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFL+0FkGip5/XTYUBCqFcvtvF0uWU
MB8GA1UdIwQYMBaAFMwurYmMg+NAoyVppeqSfdI3OsfGMA0GCSqGSIb3DQEBCwUA
A4ICAQBGpYYvkjNsVP7geKv1jY+KtUNmyx8vlCoOo8tZ5Cc76175ocrVs50lZit+
nHWXe9Lqnuu1fMo+0jEpgC9dqy6cCxAEgNH5kwbFxXFPHOB/kxMdWubZ1xwcOP2l
B4ns7Ps9RUGOIcpfuAp2KLYwavjO58g+6FVGhY3R6VAhmNRO6bHhz0wQRwKAZNo2
GMwYMmxW63mI4bz1JYvCSeZtqZhyxTMDOwEUDdYkxrz3g5gQUoMnrrak1kGRdpFB
Eefok8aK8ngfwwIgefNBF9BnzoRhlIVrm3//zboqShj4IXqMEUgScWNz2WTjqKaU
uhLk+MyynNqrbp6EeFZ0BPgA7AfVWevRf4OOCxrH6S4FJtMKmuczZ0wqebTML7Ax
VtkSqeT7/NBDTh8D8j+HVvHwMi4s+cunS3DMdXE9yzuixlcjfsD/2aS17quE23Qf
nNESdDy5TUs5Wlm1ClYQ+L1cZGwSwAyqMs9RNg57+gtJu5Uhjn+FGVLndGQgzIor
/+ynq6KEzN2rhGzLpPHpwUdDoX+YnNlrZpdx/IOgknaSGznJ/mQzA6PjffNS0Fx3
pqd41QO0uX5HWDFEa/gG0Uo7faymzXFcFb9AKCrKR5Xrd0W+f2U2z/hvC843i9q2
8CoJ7xRMt0wF8Sun9U278iaLgPNNyCNDJorz9NmIomvT45XK7jCCBe4wggPWoAMC
AQICEACzBRGxFrSgVlEdfGgfh30wDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEfMB0GA1UEAxMWU3dpc3NTaWduIEdv
bGQgQ0EgLSBHMjAeFw0yMjA2MjgxMTI2MDFaFw0zNjA5MjIxMTI2MDFaMFMxCzAJ
BgNVBAYTAkNIMRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcxLTArBgNVBAMTJFN3aXNz
U2lnbiBSU0EgU01JTUUgUm9vdCBDQSAyMDIyIC0gMTCCAiIwDQYJKoZIhvcNAQEB
BQADggIPADCCAgoCggIBANT7+j+GoplwCTrJ1qFOAc5GtS0kSA1F6azJGtcygKTm
08rW8ik37Jos1oHO5hudsQ9B31jTX6qgeVkLjK35xfkc+8PpNUB0w8EMy2f7nF4M
I/nQL/pMgkUctfUf+Blu2pO3TmiDfmItHYyVH3DZzlqMIV2ovgipVm3Z97mQmcc7
172eLslnVy4hzvAyg/sEAfm3gkQNsst6CaFIPk/AC2obG+zPHZ5/BpCsKAULqOZU
O6KnLDkTmaj7NOv18L0B2IgRyK66GQJJAtyKLLS9YWDsnXhcaosvF4Ze8k+TAGtd
xbKppRjq5m1+VwX7B/y8fKFDsWYcqGf7qzf2qqq4ekH3OdWMn65yNifkYsZDmfGh
Qen/iZ8PSa/JFAYXJ2Q5DaW0KlvsPPufxV/GO10mGfKEKbiVRAlS/Www0GKPKKWB
liuULyZ15AmMCt84835dOI6Cmozcnq7OEkI6IvI1jU/SGshJMwv6Nj//LGtqIHFM
za0QP2kyhI5c7lOIROLdzAMwkoZ5kCpLdftSYsT0b0332yOhGN1FUxeaYyRIiSLN
fpsBHIAoA49bK/of43wZveaPsUB2oPLHN7IylBAyzacTl/E7LHo0Int0OkDir4L4
wcF4/F/kNX/A9EzwTLLqhwNyJVmDKgikUd7P7qjn6EA/iPA2qwlO2KCof/PhCdu5
AgMBAAGjgcswgcgwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUzC6tiYyD40Cj
JWml6pJ90jc6x8YwHwYDVR0jBBgwFoAUWyV7lqRlUX64OfPAeGZe6Drn8O4wDgYD
VR0PAQH/BAQDAgEGMBEGA1UdIAQKMAgwBgYEVR0gADBSBgNVHR8ESzBJMEegRaBD
hkFodHRwOi8vY3JsLnN3aXNzc2lnbi5uZXQvNUIyNTdCOTZBNDY1NTE3RUI4MzlG
M0MwNzg2NjVFRTgzQUU3RjBFRTANBgkqhkiG9w0BAQsFAAOCAgEAYJlzjmIacHj+
LoIBLpUOWy6pKERKwJdT+0f+WA4GJBkVs+L6cXfOX+3UiYuh/6SjaEVX3WkrrFgm
u9FAzNGZo/DInv0Vvs1bviZox3O4Iy6PJXOpmCKaI3dJ1TBNtB6qhldfKxVAdRge
XrC8twyDmcnq6zuAqcbyMOTIKkuLlmh2ElIXa3qBfV/YrYN4Yy+wdskI1XIlD7mW
wkAqqWonKyQ6yev7pNg7Eoc7VV3W4EjhClZgldt9NrltNbu9HOmeOHg/MqCwtA/o
UV69vl2uSz7b2O5y5oAlwp00ulJAczxbMeq6GSMy0DoKef38ly9rgQ1XUqmrMBQr
FodZFJfBMxTtiv0rjLJY+0ZazwawJwhqCDOL4wa6BVPb0HDtNwAF5M8U+TrcdpJ3
3AJK8Qzx0SwZR/o0uRYumn09fc/Enp13uagFpZZ1mWZCu4XW26f2XZLT4q24Iiuc
UYJqYDPsiyvJcHXRcWWQRgO+jxWHFrVu0bpqmb886UleBJ1g5l5eo7qPezpMiJYS
ax0mUkQdwrWYXgg5vv+VEZkHF+ymgszCM4VqW5LJLUmMlS7bT9AFzk2ggWX9XzLC
BKHQnBHTLzqNRCIc4ozKycKJIBdm3jWoVDWCFJjMJ1xyzZYABz5bhnYmhoajN2oI
ozoWd/BrXMidmKJJzItOZc7B4+yixtQwggc7MIIFI6ADAgECAhRwn09/eALzU6fo
mxD9FZ7NOoMhtTANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJDSDEVMBMGA1UE
ChMMU3dpc3NTaWduIEFHMSwwKgYDVQQDDCNTd2lzc1NpZ24gUlNBIFNNSU1FIE1W
IElDQSAyMDI0IC0gMTAeFw0yNTAyMTkxNTM2MjZaFw0yNjAyMTkxNTM2MjZaME4x
IjAgBgNVBAMMGWRlbmlzLm9zdGVybGFuZEBkaWVobC5jb20xKDAmBgkqhkiG9w0B
CQEWGWRlbmlzLm9zdGVybGFuZEBkaWVobC5jb20wggIiMA0GCSqGSIb3DQEBAQUA
A4ICDwAwggIKAoICAQChQY7Fa+v6FGTGYO1sxpBbimGvkVy47z+7DZPOJogJdI7Q
so/IKKhwKrBIRTDMdLM1AkUIsK7UIu++3sm0rNc3sBf6RKYnjH2o6V/pc+HWPefY
bIRutw/gmkT7b9aP2Wmm3PtjnasrM+RdDlfGKqHkeCR2zkeRDDP2BE2LKc9CFGJB
PysNjZSVlp5/fxb8atVwVk+TphIHuHjeP+3z/ykiDr64Yq2yjyNlXrWVg2yxju4M
LdX8wfkCx/uAIlYLACinK+/RATAYz1f3Y+kJ81CQbfFpnFZBRhxjDfj65zxMrWsJ
ydnoGsZUHt7zXFOQvw7JrFL/X5s7hBv/3uy107vBwcA8Hyw9m3DH/ChBMen6gyy+
CkNXalP9AOZ66CoEgIE8PfsrzfBVjVxQq2+iQLNlJ8a1r6URPNd5h1YZILBy6yTK
8tUs5MbM2CjbXAylEC1P02GFKhh/aN0gW5RTRk3vpA64KPQ/ckvUTmHVWONUE9cj
iE1/MVDuc+tMfQus2HBQ0LH+EKaVZmsA1OEKujelRFleMEpBBWS0fQ+zT2Y4bfPZ
RB5iQLGLf9hSacG+ib5cid44OL6s9kjzE5+Yy70LNcoHwIaQzqoc6t7sFNVDecMc
tTbrs+raTu/cOMSc45aEDKXjhYw46cyuLwnY9DauweK3K89jUrCNqNqPwQke6QID
AQABo4ICCzCCAgcwgbIGCCsGAQUFBwEBBIGlMIGiMEwGCCsGAQUFBzAChkBodHRw
Oi8vYWlhLnN3aXNzc2lnbi5jaC9haXItMjZhNzFjMDktNDdlYi00NTVhLTliMjgt
NGJkNzJkZjA5MjhkMFIGCCsGAQUFBzABhkZodHRwOi8vb2NzcC5zd2lzc3NpZ24u
Y2gvc2lnbi9vY3MtYWFjY2NlZDUtNjZlOC00MDY5LTliMWItZmQyOWFiNzNlZmVj
MHIGA1UdIARrMGkwCQYHZ4EMAQUBATAIBgYEAI96AQMwUgYIYIV0AVkCAQswRjBE
BggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dp
c3NTaWduX0NQU19TTUlNRS5wZGYwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL2Ny
bC5zd2lzc3NpZ24uY2gvY2RwLWU5N2YwN2M0LWU2MzQtNGNlYy04ZTJhLTA0YjIw
YTdhMzBjNTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBaAwJAYD
VR0RBB0wG4EZZGVuaXMub3N0ZXJsYW5kQGRpZWhsLmNvbTAdBgNVHQ4EFgQUcDNC
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

------E086469657478513811EB6EB5AD6D117--



