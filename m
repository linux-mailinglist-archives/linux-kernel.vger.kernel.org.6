Return-Path: <linux-kernel+bounces-379169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6D9ADAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A7328361F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39816FF4E;
	Thu, 24 Oct 2024 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.deadmansswitch.net header.i=@mail.deadmansswitch.net header.b="i4xC3Xcv"
Received: from pc232-10.mailgun.net (pc232-10.mailgun.net [143.55.232.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5BBA4B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.232.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744470; cv=none; b=di8AK9lNUxUCziHwDh4sAWbEJKoAoxN7s42r6NMBi2bVm7x4M9rOtf92OChj+xDLOEDXFU4ec7vmmwawN9SFH6fs6gMj8CFLJn8hzXw2XszrSuIyhbusZTFXfsywyA/aVHqQ80GsNdhWp/sgfQjp9c2NUVUSxLMONXxNxjq5fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744470; c=relaxed/simple;
	bh=wHqvzuP44osqIdHWOKtEhKT1T4kIqMOXpjW8nAKc1jU=;
	h=Content-Type:MIME-Version:Subject:From:To:Date:Message-ID; b=kubpvrkCJfFlXOMyR/AzJF7gEZbDXExxGl/EWyakiS28WvYRk15zQN9dgGlHyIcHZQhM8R9pXxhRhRjPQur9dWyD7zwS8ttgUklTvjzdKB20Fn1tyrBCNSTOO1kI4Ft9rOmQEICFqPq271sN47nzY6WPel/a+pGN4SF7BNnd2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deadmansswitch.net; spf=pass smtp.mailfrom=mail.deadmansswitch.net; dkim=pass (2048-bit key) header.d=mail.deadmansswitch.net header.i=@mail.deadmansswitch.net header.b=i4xC3Xcv; arc=none smtp.client-ip=143.55.232.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deadmansswitch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.deadmansswitch.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.deadmansswitch.net; q=dns/txt; s=krs; t=1729744465; x=1729751665;
 h=Message-ID: Date: To: To: From: From: Subject: Subject: Content-Transfer-Encoding: MIME-Version: Content-Type: Sender: Sender;
 bh=wHqvzuP44osqIdHWOKtEhKT1T4kIqMOXpjW8nAKc1jU=;
 b=i4xC3Xcv0Ra3sbDrlqtc8KHOVoNE/AFw/YSDRFKprf0dU34AFKa+ygEVOgf7A6X7fU6irGoWemuZ2haPtCY0shHJ5FGlVFgp0d2sIWqkPvctorUn3/XITttwauHbtYNGP8PxKWI0iX4hTFFtB+uhqUI96K5/epFeMRrT1ZmKFGfAqYNJabAoQW63TImhrfFc975/0wWYtP+Bhm5e2qlzYe9kB3Q8QhGoaI6hIa6l9RtOvUXSYf6qujOHkseugKy+TdeayP74b9toxL17Ptj52S28sbHBu54Oh6ZWb3+w0jqezqNvACeOUDIxPfcXyKPQTBdWj7IBP1b6RFBqz6R3Cw==
X-Mailgun-Sending-Ip: 143.55.232.10
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyJjN2ZjMCIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJjYWQyOTgiXQ==
Received: from d5caf0f646d0 (projects.stochastic.io [195.201.40.251]) by 95d95fad09f7
 with SMTP id 6719ce519f6f4c8076ddc73f; Thu, 24 Oct 2024 04:34:25 GMT
Sender: donotreply=deadmansswitch.net@mail.deadmansswitch.net
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Your login link
From: Dead Man's Switch notification service <donotreply@deadmansswitch.net>
To: linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 04:34:25 -0000
Message-ID: <172974446509.16.11489836289145131169@d5caf0f646d0>

Hello!

This email contains your secret Dead Man's Switch login link. To log in,
just click the link below, and please don't share it with anyone, or they will
be able to access your account.

Click to log in:

https://www.deadmansswitch.net/auth/login/Q6LH7ucR/

Please note that the link will expire a few minutes after you requested it, and you
might need to request a new one if this one doesn't work.

If you didn't request a login link, you can safely ignore this email.

Thanks!
The Dead Man's Switch team

