Return-Path: <linux-kernel+bounces-424482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1C9DB4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C0DB20BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B01917F1;
	Thu, 28 Nov 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QNUrYlA0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60833155C8A;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787048; cv=none; b=ifypE0NDgUVOn9tr9JdwAZjF6s/hUwegl+fB/g3ooPItF7ej9ZD2iiFAr/5gmkcGXPpADRLNCGSAa52MUS18rRi6r4GtbWGV5FnxD7aMZ0OrFlrWy0qqKPCaTcHBysDv0kHlVsfP1W9ZmT6v15J4jFqCwJ2ND2Wl3z+y07FcWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787048; c=relaxed/simple;
	bh=AL+tNQo2A7BjHVG7zZ42aFGYLnN5YSWtwas7LI4qWs4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=PQu3wgEmIJN5kO9a8qEpw95Uz15eQWiXNaOYo/vnD/xwClvVmJRaLydD22wlrkYY8YqgGHTQ+HPkQKBt0wJBewSdP2mrtgW4tsVTkb4XYZKyzaOfJU4PrLndTmH6oOTIyl0jlARiwmvtgZ5RdvbQ36LYwbFq9AM4m5qBRI41Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QNUrYlA0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AL+tNQo2A7BjHVG7zZ42aFGYLnN5YSWtwas7LI4qWs4=; b=QNUrYlA0dxw3DHRJeudQIIlnqG
	d6Sp9etozvrLyYgY0psv0JwT/auqa42lXMX8a1PStTo+z0M95Bmv0Wl3+aekSa3WYJgJ2HqzLS2ie
	S+VnPn8h2d3Ht4hISHDQ6j/PX1y0NXniomlaqnSu+LO6pqmiqdimyIQt47AljblTfG9oilvIyO4Sz
	O+x7l4eJV0dIyeDVa7x450n5NAuY97LhVHvur84bmCMzaWyYE8aazYtv19vpJSqVZj87U8ape8ZRg
	UrCd9HX0ZmcEFlo3KJgog376ZwGjNeRpp3x9ljcM+l7oD+V0lMrqwqx+Zd7Bf0XSCHZAQDDHDMKqD
	nXMRP4lg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb46-00000002Tpo-0cGw;
	Thu, 28 Nov 2024 09:44:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 00D75300271; Thu, 28 Nov 2024 10:44:02 +0100 (CET)
Message-ID: <20241128093851.469225872@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:38:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/16] objtool: Rewrite annotations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Rewrite/unify the objtool instruction based annotations.

Changes since last time:

 - removed unreachable annotation
 - included reachable annotation
 - various smaller things


