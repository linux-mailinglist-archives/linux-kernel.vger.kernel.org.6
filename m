Return-Path: <linux-kernel+bounces-408554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D768B9C8062
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B563283BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF761E571E;
	Thu, 14 Nov 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AFAy1znJ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE11E47B3;
	Thu, 14 Nov 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550075; cv=none; b=o30xBY4HsnIJPd8DyvAUYnAd4o1PeehQ4sfl6u+T9J2JkdQaTJijICp9h1N/HKFMgVaamEu2jbnzx7Ls/hZ2bd63u+2zFDSkF0CrtVxX7CKcCAOzLVaEmDaqgpJgr+D9gWCuvB3hFFd8UggmLGWLA6pcWWfnno4tifipTW5TP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550075; c=relaxed/simple;
	bh=BBfagTzfNiRjzEL6QJhFtCCEuOrztefDgMR7OwNToOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m118/CsnNRxyLZcTU0Sp87hTlviBCVeFhEY+17Yp8OP3EsIjcaz4v+8S9dOUFwEILLJkoGvAGq55AsEQDriSS+q8uAYutPVTkwiD/TSPs1ihp4gKwee633/4yNb3lGBVd6GujUP94LnCD6GgZJJRnpTyKNNjTDO/UFNntimr+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=AFAy1znJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731550068;
	bh=BBfagTzfNiRjzEL6QJhFtCCEuOrztefDgMR7OwNToOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AFAy1znJh6ppKfBr4FJa0ACTelaEk8pXJsDu8CS3b2wQm+PJYmzITG/Ntgwi6snio
	 BpMtbHlgSXuvYotDSHnriKnophoLxPHJck3I1ztJ5QnMHLMIe6plxj5ivLMe5S6eZf
	 j8RPk3oTBtQ8SQca8/FMbcnGWZcqklbXIifxkoIb5YA7dy+qfv8NvrQczYYTa9R+Np
	 6Cv2GVWJnpq/Y0MBm722o3umVRoBgi95qcCBYG2lXMkefPWV3dedjZZBUIQVTExEaE
	 EC1VBbzFB60eT4/0UA/qyEBY4VRst2WF04R0eoKyN+7Iu1ar5ROmGxSLlSv3xSbzpY
	 U/JNmL/8vFO9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xpk7l64Qxz4wcT;
	Thu, 14 Nov 2024 13:07:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>, linuxppc-dev@lists.ozlabs.org, Conor Dooley
 <conor@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells
 handling
In-Reply-To: <CAMuHMdWk83QpTcbuBz=m6UZ+ShFM4rTt_UL-frzR3LmAf_Tb2Q@mail.gmail.com>
References: <20241106171028.3830266-1-robh@kernel.org>
 <87jzdfcm3l.fsf@mpe.ellerman.id.au>
 <CAMuHMdWk83QpTcbuBz=m6UZ+ShFM4rTt_UL-frzR3LmAf_Tb2Q@mail.gmail.com>
Date: Thu, 14 Nov 2024 13:07:49 +1100
Message-ID: <874j4ava8a.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Thu, Nov 7, 2024 at 12:37=E2=80=AFPM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>> "Rob Herring (Arm)" <robh@kernel.org> writes:
>> > While OpenFirmware originally allowed walking parent nodes and default
>> > root values for #address-cells and #size-cells, FDT has long required
>> > explicit values. It's been a warning in dtc for the root node since the
>> > beginning (2005) and for any parent node since 2007. Of course, not all
>> > FDT uses dtc, but that should be the majority by far. The various
>> > extracted OF devicetrees I have dating back to the 1990s (various
>> > PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
>>
>> I have various old device trees that have been given to me over the
>> years, and as far as I can tell they all have these properties (some of
>> them are partial trees so it's hard to be 100% sure).
>
> Apparently CHRP LongTrail only had #address-cells in the root node.
> Interestingly, /cpus does have a (zero) @size-cells property.
> http://g33rt.be/migrated/Linux/PPC/root.html
> http://g33rt.be/migrated/Linux/PPC/DeviceTree.html
>
> No idea if any of them are still alive.

OK. We could fix that up in prom_init() if necessary - there's already a
bunch of workarounds in there for longtrail.

cheers

