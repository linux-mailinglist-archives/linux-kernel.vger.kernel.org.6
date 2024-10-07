Return-Path: <linux-kernel+bounces-353936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F679934BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E74281F19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974B1DD55C;
	Mon,  7 Oct 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jSCwvQZi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FB18BBB2;
	Mon,  7 Oct 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321607; cv=none; b=HPQu3C7eWr3pl4HdBQNn7xVwABQSZI4xxgR9weNy3ObHsOL6fnrbyusmSYGHujU8XAtqN7vHpRV5AW51TAch8y02s66fkh2V//6AFo+kBsKn0U98YQaa0y5KWzmhbvxBolsKEaiKYaXFmMhlYBbNDcoHYuWW1QUnOdEA9d5QSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321607; c=relaxed/simple;
	bh=AXhL5/fpZmTmpYZYdSbfVa67sVSZgiynBzawvU+OM+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMjp7tvfYGbiuINkm5hUpAouEUBK4NQ4OQM2Fzh9GC3uwMvprTheJditwR6l34EigMFreK8UHn/COhJFg/iUgF2Os7CwgeWBrReHRDOsE1549y8idAsOSDcJRIRFgS5+dJ5qf0WMe40Qo60pjPLtQVlPqUY68XW3W28s8urhZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jSCwvQZi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EBD7642B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321605; bh=UgszRIWEzyLDrlT97QaiyvYlsMj4p6TaNFZIxLmyX6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jSCwvQZilrPO5Vx2QQCa4DN2giBngFhA563QGGVfM9QE1n6grWDNAAxALm//8ZteJ
	 KXt3/hJZOTu8zxuVDlnxnQevKfoy/MCl9KvW71pHjDZWbXNj2tzr5+cxdoxL6YjDi+
	 siiXqz85O4QsAGO7FVd9varQyUXjop6uxp/WlgtDJhSieykb9ldwcd/U2hFVKS9zFZ
	 xAnVsEBH589/x2RTZHtkSmfh0Pf05mqlEiNb9KZFwVX5Qseegpt0MwwL46Izn6KOOy
	 kKD5dqFlQOZ/xVdEFGVaehJH7lFpe//jUkFvgejATUSTRCEOPVNBBmrOWt+GW4NOpm
	 shdHv9bgphBow==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EBD7642B38;
	Mon,  7 Oct 2024 17:20:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, ojeda@kernel.org,
 dirk.behme@de.bosch.com
Cc: alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 bilbao@vt.edu, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH v3] kernel-docs: Add new section for Rust learning
 materials
In-Reply-To: <20240922160411.274949-1-carlos.bilbao.osdev@gmail.com>
References: <20240922160411.274949-1-carlos.bilbao.osdev@gmail.com>
Date: Mon, 07 Oct 2024 11:20:04 -0600
Message-ID: <87set7j0e3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> Include a new section in the Index of Further Kernel Documentation with
> resources to learn Rust. Reference it in the Rust index. The resources
> are a product of a survey among assistants to the conference Kangrejos'24.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>
> Changes since v2:
>   - Fix wrong title and added date of LPC talks.
>   - Add more resources proposed by Miguel Ojeda.
>   - Add review tag of Dirk Behme.
>
> Changes since v1:
>   - Added two more Rust blogs proposed by Dirk Behme.
>
> ---
>  Documentation/process/kernel-docs.rst | 163 ++++++++++++++++++++++++--
>  Documentation/rust/index.rst          |   3 +
>  2 files changed, 155 insertions(+), 11 deletions(-)

Applied, thanks.

jon

