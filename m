Return-Path: <linux-kernel+bounces-244746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4D92A8DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624E328276E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197B1482E0;
	Mon,  8 Jul 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbJrP460"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917F28EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462600; cv=none; b=uePzef36UUXgSUDLMujxXbvlLBbGuJ1ClXWbC437MJHAdJSiatDXkb8gEuiWMZYeXJKMCKwkP4KT10ROMJWLxGNtaRK0IHpzkRm+W5E1XT9c5KNUvqgIxqtmuZQKkDBcwRQZOGz4xx89MWG0DUZimridI8TSlONYzdPR8HGpyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462600; c=relaxed/simple;
	bh=MmroBpVwQZq1Rgl7ho5wQtWJf2833Q34uSFgt3YqTeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+ep91ZutSb9MAWUkFfvxTJ8Fd7ik/gJjbCwVoeWUE0zELhXM8piqHFGiUSLVupR+3TWh75Rbl8aqmLBYMmiAVj+QHgEJviCxlk69NnLrHnGVbt24xRO/e3JGCXWKsgOT9rcj9anJd64MKD9xyVwCixdQkOixgG6aquJ8jGQTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbJrP460; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929FEC116B1;
	Mon,  8 Jul 2024 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720462600;
	bh=MmroBpVwQZq1Rgl7ho5wQtWJf2833Q34uSFgt3YqTeA=;
	h=From:To:Cc:Subject:Date:From;
	b=NbJrP460+C1Y75haVIngSPb4QcmZ+IM8XU4jR+h7mh6/qVSKH9JtbGu3l2dGVDUrB
	 4+LQBT/RKALA2KKz6/Gc1/sPvR/1JOidaI9uUqAVKjKdIoQ7qx23ck+ltQMAKMay/P
	 KTVkkfUBz3G+GJybkCO1LV7CnpYx/h8OxbdI9wruiviUYtLDmng10McuX2x4mNgvRi
	 7loOkSlbANaH+a/1kRzvHKLXe24CLxP12W2rBIihDaMLiadl0Ul6Qe8iiwRJG/ChR8
	 z/FmuHDmMllInas2ezv2UtLKlx2In2+JzfwZ4crEaiSGJcjPvQkDEcGYZZlyHRrT0f
	 Vm933omRtoxLA==
From: Kalle Valo <kvalo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, ath12k@lists.infradead.org
Subject: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Date: Mon, 08 Jul 2024 21:16:36 +0300
Message-ID: <87y16bbvgb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Arnd,

I installed GCC 14.1 from:

https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.1.0/

But I have a problem that a kernel compiled with that compiler fails to
boot on my x86 NUC test box. I don't see any errors, just black screen
and I assume after that the kernel either crashes or reboots and goes to
back to the GRUB menu. This loop seems to continue forever. GCC 13.2 and
older from crosstool work just fine.

Do you happen to have any ideas what could cause this or how to debug
further?

Kalle

