Return-Path: <linux-kernel+bounces-377835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD759AC769
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7D41C20CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAA19FA9D;
	Wed, 23 Oct 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qR4NdsHv"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0FE19F101;
	Wed, 23 Oct 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678153; cv=none; b=RoLIWahYYpMljyG773fgkcew+OiquMJFG8bUswgaZ4Ukdf5dd7uy0vqNI7ajkf4OgYKCmcrX5tIGkdAl0+D0b0U/sJUW3kX/4bACwGo9eQAfmfVNVAmJpssFyE/csJpnDbgqvbzqCSd2Cun1kNxxkVZBwTr/vsfaVz87gA8IpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678153; c=relaxed/simple;
	bh=SQe9/NllXGBOcEetHIExMLBl1DMZNh/EWykuYoQAZbk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5roQ0LY1o/X8yPzXY2edmiMnzIOaVziTuyjfCFHIHlisgvKLitcY16rUrF0tg/wmLu6ALy5RsUE/FCJCGdqTjsB443x0FHD43goZDhwyUwNbAmuvaQ3z5UyLwzVy0Zzy0N5p2IR3qfS/rwLk02u7Nc+/C/stKdEj1HXGG/Q7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qR4NdsHv; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N5Ogo6005492;
	Wed, 23 Oct 2024 05:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=SQe9/NllXGBOcEetHIExMLBl1DMZNh/EWykuYoQAZbk=; b=
	qR4NdsHv0blse3jLGMGXoTwuWEo+7DVO5HZLqugec9vXZdyDPfflmGAnCgB3EO/l
	kxZIKdemCrS139qFYGmaVgxpggzH8ZBt3P2ByYzBZZzcdRz/WHInaYXhIjtCCIt/
	SR5dmz0S7d5FzBtq+I7yok7uKbU9HOOEcxkNfspxNzukW2uCPWpESknGk+wgrA9v
	x5g8NVl5lmGHSS7KKlo1lDWMvN8BHUsEbCPfeyvb3La97HtF8L1mI13OAcze8sbF
	5q77xI+SD51S7mSyLLywgVt19+dNELhBKue4hs6yLOe7sjsZQ/Msn5/FvCV/6dqc
	ynedvnCoz5REtiLCDIQz3A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 42ca5x4v0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 05:08:57 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 11:08:55 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 11:08:55 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1DC3E822562;
	Wed, 23 Oct 2024 10:08:55 +0000 (UTC)
Message-ID: <40cd7e26f2b26a37f38bf8830de2a03c51be540c.camel@opensource.cirrus.com>
Subject: Re: [PATCH v2] spi: cs42l43: Correct name of ACPI property
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 23 Oct 2024 10:08:55 +0000
In-Reply-To: <20241023100636.28511-2-mstrozek@opensource.cirrus.com>
References: <20241023100636.28511-1-mstrozek@opensource.cirrus.com>
	 <20241023100636.28511-2-mstrozek@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: h_u62Qh8Yj8xnRd2UEzIhJEyxHiIBDYp
X-Proofpoint-ORIG-GUID: h_u62Qh8Yj8xnRd2UEzIhJEyxHiIBDYp
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu =C5=9Bro, 23.10.2024 o=C2=A0godzinie 11=E2=88=B606=E2=80=89+010=
0, u=C5=BCytkownik Maciej
Strozek napisa=C5=82:
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
>=20
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
Sorry, sent this old spi v2 patch in error, please ignore

--=20
Regards,
Maciej

