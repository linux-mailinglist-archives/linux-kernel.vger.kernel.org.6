Return-Path: <linux-kernel+bounces-421836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21479D90BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB29B21EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98066BB5B;
	Tue, 26 Nov 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UArujJNC"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1AD51C;
	Tue, 26 Nov 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732592205; cv=none; b=SGgsYWCIdkcu11Vw5VTjaAfV3KSntTDcFy4+nkr4P/VyNykCNL6DcWjBEvWXPFRB8tf9MRJ4LHUTj1tNshKzQTJllOnZqQ59kF8YtRiy1NY8IP/mJSuPZD8/PwW2MLslyKdhNs01XHPq0gXcn/UE8v0TpCqUsbGpWjFZxlzzT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732592205; c=relaxed/simple;
	bh=qwqh95MJ/nfBFFV/woCExG+ob+AztGp2q/5LGjxsCZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0y+hQWLbXg8iK1emmCQAptyBU6CxQ8FI6Ju3pASthpfn6LT60VbJu0/cEPQv0+C9Lm6W8avL2wf3ImyfJNiVm59XIxaIxTww5dQN90LctQfyCmmhCjgFJ3O3/1BedX76d4RwsgmJng244FDiNfiLNfkBwq+QMOLS1etCB+Kgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UArujJNC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732592198;
	bh=vHiA1DRTO6Lz/YaaxntcT3ZGiZJBg9vrvS0JqD9lF8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UArujJNCgfKANdoEUFU/xDCir05HT5vCMXOIZj8M45wg/RePEIz0kM/Y5TQ+vJ+i5
	 XUQ9uh+k1oZEA4MJ28mW7EJdLbPRW9OTcQ4OFjpNemNAqgpKeRM3UGFzBaU0gytSqt
	 Xhy/IM3n3qPp9zy9MDhV8D9KQRg+MLTfl+lWNNbCynmFM+szYgXaYG85nSsxTzGuTB
	 XAXf6KSPoPTAUaROrcmCIofctWQ0AGGacFAUFXOvQ0XGkfiPYc30WAZb+3EWTrY9na
	 fNWfNvjrPJacvtMc6mkYlA/cxYV+lN6axkowIbJBdUAmCfHRtZYZyAZ/sb6t0QLqzI
	 5DnoaG//47g+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xy7Xj6YMGz4xft;
	Tue, 26 Nov 2024 14:36:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells
 handling
In-Reply-To: <87jzdfcm3l.fsf@mpe.ellerman.id.au>
References: <20241106171028.3830266-1-robh@kernel.org>
 <87jzdfcm3l.fsf@mpe.ellerman.id.au>
Date: Tue, 26 Nov 2024 14:36:32 +1100
Message-ID: <87plmi7jjz.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Rob Herring (Arm)" <robh@kernel.org> writes:
>> While OpenFirmware originally allowed walking parent nodes and default
>> root values for #address-cells and #size-cells, FDT has long required
>> explicit values. It's been a warning in dtc for the root node since the
>> beginning (2005) and for any parent node since 2007. Of course, not all
>> FDT uses dtc, but that should be the majority by far. The various
>> extracted OF devicetrees I have dating back to the 1990s (various
>> PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
>
> I have various old device trees that have been given to me over the
> years, and as far as I can tell they all have these properties (some of
> them are partial trees so it's hard to be 100% sure).
>
> So LGTM.

Turns out I was wrong.

The warning about #size-cells hits on some powermacs, possible fixup
patch here:

  https://lore.kernel.org/linuxppc-dev/20241126025710.591683-1-mpe@ellerman.id.au/

cheers

