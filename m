Return-Path: <linux-kernel+bounces-550058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2499CA55AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A21018903DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C026FA5A;
	Thu,  6 Mar 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b="D50cXPbe"
Received: from outgoing12.cpt4.host-h.net (outgoing12.cpt4.host-h.net [197.189.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4917B50B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=197.189.249.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303198; cv=none; b=f30Ql9IkqhEEHVTKprPRfk4Kkm3ik4f3VbtMVtVulrBKnYiAVvu6dmBilubOXxl4Gbl+IYrFmB2vJctQGXoQddut2A0FP1wBU4OUz6Zwbr6AJ1JSgKPcx/xJ6HY7VXEoi62prK5LyMrN8t8FtPqRSUefttXFtamEa237fQe5DD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303198; c=relaxed/simple;
	bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODSooyPa152wL2oDXBQJLNsQSquXZa5RCAOYDJVpD98BopvYZh3Wy8Kh62G3VWccPoqv2eSg3JPlIH1fglpY0pnML+TB0bvQO2xuV21E6C/9pdEo7EM4Y2BIBeRnfvncQF2yalICjV2J/PxACR3p/3Wadb4oFXJiEKnK+61WwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za; spf=pass smtp.mailfrom=delugo.co.za; dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b=D50cXPbe; arc=none smtp.client-ip=197.189.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delugo.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=D5
	0cXPberYzdJiJ37RMBz+4IND8jjIoMkUgtOZIin5aVZQ2tPQsVh1khMoQoe7AkRLSp+wq3PqiNTIs
	NdDmgJyLdm676hhQJ9W6zAibRJWWEHiHdu7L/aIslDuG0JYptInLvFpQ6zUmxjAIniFbboluvscKF
	J7VLVATHVp2j/zBGk6VbTuJDJVxawj0T/C97z2f8wj5uR4iCwChC0FlIyXIS5myNHuS7wh3XnCEBI
	WQCn3K0fdSgFpfa8qsjlpD+2K96nGXUlSidMA5tk7dnR6GCARg3hM+hIX4Hbyc7K4iSmj6mOIS4QE
	jVHvRZNga2KaQ9hRtIrNvomjbvbJ/iUA==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam2-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqKVK-004OKa-Ja
	for linux-kernel@vger.kernel.org; Fri, 07 Mar 2025 01:19:51 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5h-0000000DmMl-2vJo
	for linux-kernel@vger.kernel.org;
	Fri, 07 Mar 2025 00:53:22 +0200
Reply-To: barry@investorstrustco.net
From: Barry <orders@delugo.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:53:20 +0000
Message-ID: <20250306223012.83216282CDA47B03@delugo.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bREpFrWuWIErUdLmeH3sV3O45WCy5VkstzhnxgTXqsdmp93tZpAdvdS6NdCJ
 /MsVqHuXEsqnyew3ipF20HtD7QKEX82fFMCHt5FPwO48dek/G3ge4rT/IYIw0bHqyr+G4W9q7i40
 Cv3JVydIoq+DWRCN64EatAMbeT0rA0cuSgwLzJx06IuyC+tcTGxdYh5dhAOrMIibkpY46HKySyiI
 2P6osIZXKmwzbGT4VvpTL0Eb54bT3EszvIbAbB2Zy01d/7IXjkdTeVZ2qGWx/wHRpX68XAT1wNOm
 7rTlk+2JSJZUd73mqu8smbp/HRTQbIV8i36V/c7g31viaan27/VsoWnQPP2nZVsMwXoTZLRadQLt
 9HGlfXdmgJrKjBlTpWs78y8XcyZ/7+cSpFkndHGnqif7SugB+UXSiJRAsNSvmUSSESCv9TR+UxzL
 ZWL8hwGBjhoiDZaHjjUjL+gPrBh/8n4kpYzALSfDrtQHo6yRgtyrJfVAoUtwvTBLoObUYKePXRP7
 rm34/uxG6FZ8RaT1Xv9+93vo6dDwKL2wRawsexyMMyR1OHiYpYJNGAcAxGKPZRWKHYcWWwiikDEw
 0L2tQ2Vz7QgdxtQsKWiN2eBEpDFg1Zy/cfYLvVgZsotYLIYfY9Y+aa2INOiN0dwEFrB8fRj7/fu3
 x7erbsjFB4F58vtkzfUTcOlNg5c9S40yaeOfa8ZIP3/t6uYp+aGrapixiiwoGKSWdDvUa6BOBeS5
 Gf026D+2YJSgXyBK7ZQtGajFXeg3ClTXlSfQV8rvfnHgqk4UMNxjqSQ/iDCZlUnsRnMQqHKYrzgu
 ukArfPc4ucnPOUHHyAsi4fWXQaiJMI59iYXhUHAD0j5Mac/dfI6tvfePx0tmGPfQcJClrjUm5GSv
 xpb9irnwIUoD+//AU3UZ3+/j
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker

