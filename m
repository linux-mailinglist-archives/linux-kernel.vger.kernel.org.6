Return-Path: <linux-kernel+bounces-255433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CD9340AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3977284217
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3A181D09;
	Wed, 17 Jul 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rImgOcB4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97285566A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234588; cv=none; b=nfRv24mwNsZGMLlxsy0TDvZXvMGpfxo8V9hRby8WJi7Rzruno+699gc0W5EIWvlqhQ2P4kpnpnSv+/LKN30rgGdimp8bengHWRB1zVy7XGcnkemHcsMN7k6q6p2W7loa4+x6m86qxWCd7zKN0q5H60Kzi2Y1zpp699XBCb7dBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234588; c=relaxed/simple;
	bh=999eq0pFxZVDPfrY3MgLtoo3IEwu/lUA9qm8FSFmCRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnkRK0OYZlGV6BVZ/cvCOZCAr7IvT+kzCL3pGvtpDtYkGJRVfxyi4YEJw75+u8QVXRRinmVtK71QMge3lEVJr4gkLKnynvj4dkWPhxZ0NJB6fFvp46Bfw83xt55yG5d056gGNv5/TkNi8WIwO2HKyaiJRtq3gAMXTuW37hP4AXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rImgOcB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3125BC32782;
	Wed, 17 Jul 2024 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234588;
	bh=999eq0pFxZVDPfrY3MgLtoo3IEwu/lUA9qm8FSFmCRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rImgOcB4c6XvWAvam5EIYoA3EdeVhItjNs3pzJfyq5JjLDGtMg8Tu+HWYteyUFxfQ
	 75So3Nu/BlTpI/0Waelnk0Gc9pN5lv2C11HBrMVqpMGWt5BhaHj92MhD244Y8LE0RB
	 zAhUn4JurmcA9B03xi5+pnjp3vrhVZJmHNrqOYYXSpt9K7L4bQELFU+nZdOXvYVikR
	 qneDBCAT/MW5wW5RqxK76lYEdMkTTyxyeH5IhbQ96WolNyYl11ZFqZR+wJGJ9ANYvT
	 l6QsRnt71AN7U2WybEQtnjH1xoiT9/g5S7iSo5NZuC5XbkOLAiHv8RDJ35nbkUQNSg
	 zwywQbb1b51Vw==
From: Kees Cook <kees@kernel.org>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: Report UAF for refcount_sub_and_test(0) when counter==0
Date: Wed, 17 Jul 2024 09:42:45 -0700
Message-Id: <172123456264.2736908.1565336371503980585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717130023.5675-1-petr.pavlu@suse.com>
References: <20240717130023.5675-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Jul 2024 15:00:23 +0200, Petr Pavlu wrote:
> When a reference counter is at zero and refcount_sub_and_test() is invoked
> to subtract zero, the function accepts this request without any warning and
> returns true. This behavior does not seem ideal because the counter being
> already at zero indicates a use-after-free. Furthermore, returning true by
> refcount_sub_and_test() in this case potentially results in a double-free
> done by its caller.
> 
> [...]

(Peter, let me know if you'd rather this went via a different tree...)

Applied to for-linus/hardening, thanks!

[1/1] refcount: Report UAF for refcount_sub_and_test(0) when counter==0
      https://git.kernel.org/kees/c/cee1fb1bb8bd

Take care,

-- 
Kees Cook


