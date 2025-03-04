Return-Path: <linux-kernel+bounces-545588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C296AA4EEF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE1A171F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F42641F4;
	Tue,  4 Mar 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWbWktBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91E25FA19;
	Tue,  4 Mar 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121952; cv=none; b=RYm/+CZ+OSbhcUqgLP6IQZ1ov+5gpX5ak68f7ZpOp0WrjFcOLEh9uJjgUklZfmNbDgSyCEMRqSlZ97yN4k5/HcBp9zLJsT9mdjlNytU8OeomT5vr5vkqVsohuJEiqI9bsuC1p1CnyEm1BSpa4Y7FeOyz4buwo4D2D6UMa5MgMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121952; c=relaxed/simple;
	bh=RELrFMyc/G4fxXX2yNRBJZ22pSbk3iaff87P6+DkIow=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Pa/dce5kUQZu1CKg5nS58+hiVxxFcnh/w1mgRYLfkPZVHG7AIYAPFR1RbtYd0/xjlx6HkLavJcXMN9kj7edrkkwk+C6WzoaaNRNITt3SFmqJkIGYaRRZAGyxsagAU2ax1LYSbhGz3HN53uJeZFDjB8XFqMNOK9683iOxOUBXL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWbWktBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A12C4CEE5;
	Tue,  4 Mar 2025 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741121951;
	bh=RELrFMyc/G4fxXX2yNRBJZ22pSbk3iaff87P6+DkIow=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TWbWktBibHeBA0JcFqLn7LA0Nh3H8A6TDlv3GuKgLB3Rl/EgW2hf442XmMq+rYWHX
	 LmsiTkt1EZ82B2lFTzrEeMoBqn3vmrdybx/5V+qKX4VyzI25xwdXqkoMUx6pXdQ8uE
	 NMA+tRUh0cCnnNLx77oz/F5zrmvoX0womIPeMjgA1gR/XwtOt555yKfz8ULqw9Wu+o
	 xWqyavCkgIpOuL61ApMchVfowlsxy1Ms2CCVskofnfeBJ4R1EhnBzotOOgcqCWgroS
	 dwppkdbrW0YTdS+cvFhxa+z/s5VX2DPWTxx8opA4V3A293Srj4uTsl1uk/YCmaqkue
	 pICqf5+4zp9dw==
Message-ID: <5acbfebaa2aeedc093f8f56997eae7ee.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250207-correct_data_types-v1-1-f22bc7ea220d@amlogic.com>
References: <20250207-correct_data_types-v1-1-f22bc7ea220d@amlogic.com>
Subject: Re: [PATCH] clk: Correct the data types of the variables in clk_calc_new_rates
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>, Michael Turquette <mturquette@baylibre.com>, chuan.liu@amlogic.com
Date: Tue, 04 Mar 2025 12:59:09 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Chuan Liu via B4 Relay (2025-02-07 01:36:10)
> From: Chuan Liu <chuan.liu@amlogic.com>
>=20
> In clk_calc_new_rates, the "ret" is only used to store the return value
> of clk_core_determine_round_nolock, and the data type of the return
> value of clk_core_determine_round_nolock is int.
>=20
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---

Applied to clk-next

