Return-Path: <linux-kernel+bounces-294613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B022959037
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0051F2146C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E21C68B3;
	Tue, 20 Aug 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngP8cSVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264281E86E;
	Tue, 20 Aug 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191459; cv=none; b=omgO6AIsineZML2VuIro+vSuUHT3VGwvN0X/ROyaqLi+Ye9M/Cf3xjloCQVwt864twyZIQVR5ev4sDJHTRnT0QfjQaQL3bWtzImP3spS11TebPveBtJ8O8mPJTmuF0S6SgPFiQGdU5XHFMluudLA2079jOepnl1j4gr90bD6TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191459; c=relaxed/simple;
	bh=pCqg5t/R29AxiCJ1eeBn3fi2WEI6qz6AVbsf79SWoy4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ndB+XzB0JYFriLDj6qTpnXmpK7FYcF6siSQcc6uOvUhx4ERXWlXtoNThoKsasQgd5gzO/GH4cX8zu96uxtTGko3TGveVMfO75+1bp80auFcUyIU9RqMwTNqb+CMH06VlgnK+H8ZF/xaFqa5aQEwtYuLfGjn9kOEUbFjaO0P49cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngP8cSVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DDC4AF09;
	Tue, 20 Aug 2024 22:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724191458;
	bh=pCqg5t/R29AxiCJ1eeBn3fi2WEI6qz6AVbsf79SWoy4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ngP8cSVDANpE0qmH3iDcpQ4sUtbL9qcv9wJHOXnvYnrqEG2rTG9gPLXmE4IAq+fLE
	 TJeOTFntmATPo5kAMaX3XVXT6096x79jm8oClK+BMuxvoxNYW2mxf/+fwVcTiZuxXU
	 A5R0fFP3DD8E+FOEYjOIf7tgOtgZkfqgfXCQLGzWDix8f3kxgAwd69R50WQOwejh5e
	 zUSPWWmUycrw41EPy6OyfRYSLrL32vuKdPE1HIf6B2N5aHHTXFYjRHcqfEBIKzyuPu
	 zKb4RNPoYD8dddh07Q8gGUiPPTnH/PvztN2m1zZSDqELYnHGACCma5xsiIOBI8M0pY
	 +D/GezDkZ0MRQ==
Message-ID: <de31594913e686aad9e8965a2730ddef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPbMC74ShG6R8JEoiv29082GqN5jbkHrLcsw6fXfjWu=oAqmAg@mail.gmail.com>
References: <CAPbMC74ShG6R8JEoiv29082GqN5jbkHrLcsw6fXfjWu=oAqmAg@mail.gmail.com>
Subject: Re: [drivers/clk] Question about `en7523_register_clocks` func: misuse of __counted_by
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Haoyu Li <lihaoyu499@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 20 Aug 2024 15:04:15 -0700
User-Agent: alot/0.10

Quoting Haoyu Li (2024-08-19 12:05:30)
>=20
> Please kindly correct us if we missed any key information. Looking
> forward to your response!

Patches welcome.

