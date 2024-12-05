Return-Path: <linux-kernel+bounces-433523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635219E5984
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA7928314E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4021CA0F;
	Thu,  5 Dec 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGHjwKg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FE21C9F7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411696; cv=none; b=KBvrHXOroERUoqTKzL5jhBOMz9eRaNGX8lxD4ShPJjOkCmS6WUUEGsJG4V6Sj+hu9y+74YVYFy9By1B1Sm8Nf1XdFp6QMjuETJHKNdbz5Ylo92R8TEc1Oe8SAD2a/18kuu+4i5eW6GXLG0C4UVFrFWinMxwCv6D4r7MfVRszgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411696; c=relaxed/simple;
	bh=RMUj/5o73a3VTd92n6FV/UyHrDE6kEqc5g/3JcQECCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOY3L3/2FM3sIls8vKUhmjqye8u6xLmmlPw4xEAdkVhsSQVlk4qZnxNn9yuLZtUTj0pjr76+fgUu4nHzk1AlPy45rI/HS2/sdm6nk7/l9aWj0wc2PHxoMoUr63Yug+dnK6mIipPPVQiOFuQiDtMZXpX3xudDpJgMD1kPPwEf+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGHjwKg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91566C4CED1;
	Thu,  5 Dec 2024 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733411695;
	bh=RMUj/5o73a3VTd92n6FV/UyHrDE6kEqc5g/3JcQECCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGHjwKg/VodEe/EVR+/3YQqVaBDDsw5jqeYOs8Ik7VjuhN+Z+j/PcJltk6vnjbc6+
	 5BnC0neWDgvFF4L78BB5TrWopXTPVIpMdwnw4A6FGrLJWAMqVMSaXdxbnjHvYR/REq
	 VJSb8CYpkIcUHv+B8YOVRZVDxSZGKzlY1elkm5F2Spzs+MalN1g3SKGFB1sYGUsLLx
	 CJ92SG4v1Deylas9DelaLAv/SpbZlSDwZG0OaEbYa3AkMFTljcReoTldZDdN5OBwwH
	 gfdmICJsILxCdersUt8H411O+lArM6u+La+vP0za84i+tsnhbutISTsvVdx5q98eOi
	 BPRGj5NBicraA==
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: fix UL_IAP lock check in mpfs_auto_update_state()
Date: Thu,  5 Dec 2024 15:14:45 +0000
Message-ID: <20241205-rumble-engulf-7e51eeab2668@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118155354.697411-1-valentina.fernandezalanis@microchip.com>
References: <20241118155354.697411-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+yZkvIu+8afiH2E2mnEsGT0nnT9pwafXhP4l7o3wDVU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOmBh1P7l3k80DshrvS5MLR7kuXG4qqf+berd2oarNU8b Xh+4/SbHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIlB7DP8uA8q8ss6efYv8T t+vzmgozo/WL9+cU72wsCtpfPjU/uYKRoUckmHPF/OjXP27N+tw7IcCgwpHzjtHs/xvLgiaWf73 iywUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 18 Nov 2024 15:53:54 +0000, Valentina Fernandez wrote:
> To verify that Auto Update is possible, the mpfs_auto_update_state()
> function performs a "Query Security Service Request" to the system
> controller.
> 
> Previously, the check was performed on the first element of the
> response message, which was accessed using a 32-bit pointer. This
> caused the bitwise operation to reference incorrect data, as the
> response should be inspected at the byte level. Fixed this by casting
> the response to a  u8 * pointer, ensuring the check correctly inspects
> the appropriate byte of the response message.
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/1] firmware: microchip: fix UL_IAP lock check in mpfs_auto_update_state()
      https://git.kernel.org/conor/c/48808b55b07c

Thanks,
Conor.

