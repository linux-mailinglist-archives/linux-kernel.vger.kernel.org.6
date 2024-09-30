Return-Path: <linux-kernel+bounces-343344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE209899E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9AA1F21969
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971FF126C17;
	Mon, 30 Sep 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CF7CARC8"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94F768E1;
	Mon, 30 Sep 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671720; cv=none; b=B4XULMrKBp642dak6N/cyY0QB82oJf3ZxhhFb6ziuXMmDF0j83MikkWRtsS1lGmlDHGdwfOCGl7CMqW40bK7Ia7bFhM3U5HygYjQg1ijF3cqp7ZwowbuURBKRvpAVO99D3ogAxCC7vEIV00N3XYUE0iTdRs/7UI7bdefzE3MuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671720; c=relaxed/simple;
	bh=K46VdujDLze6B39tqqhH+d9XKkMEF7zdD9Y+hm/YgrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jITAQd353zHUaB+ryoX/UxJpgt3HuTZ3lEWa2VhgEvBTU7+pmpk4Uy59cIsR+riwTfKuzgewkZ/+ztan0NWDKxo82L9kjbgf1YhGJQRRFnhO3pouXB6UK3Lvh/+VRDLobGFOKSoFEVhFnJvE9xBEl5Xaq934MqMZ4BQ/A2nSVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CF7CARC8; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727671716;
	bh=1hzglF2sqA+Bf7TzXRh37r8UD0uQOdiDbSySAkxl8o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CF7CARC8xxgxLWEntkZJqNgC96GzIHWenfdOqy4HdExI40YCAOO+AcBKXtsCtY0sX
	 XoAcDEojl8Llca/MD9XtoQD8fKAmKg6cVwsUQZU7uk7pJEbrq+GPqB1eqJVWKAQo91
	 6XMXdcUeSUg7Lz/t1jL+N1L0ZcDfgKe/F2ja7iidiFhy1mGpbHcd16MnOhvXKYz+Le
	 C1cJLqXdlTgajJEOe72bVPoGiL9Bm1Y+J9b7gs4GXFaE6sZ6aOlvtF+Lsts53X3q8o
	 F+9jSRzU/byffMsfytWvkzovjeR+i3jhif9p7H6arNqWeaWOWKN3t7zbKdlP+mi0Vs
	 1Fo/3xBQuzifw==
Received: from [127.0.1.1] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1E7EE6511E;
	Mon, 30 Sep 2024 12:48:35 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240927085213.331127-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240927085213.331127-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Message-Id: <172767171502.99875.5222579659376110174.b4-ty@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 14:18:35 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 27 Sep 2024 16:52:13 +0800, Delphine CC Chiu wrote:
> Remove the space in the compatible string of adm1272 to match the
> pattern of compatible.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


