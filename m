Return-Path: <linux-kernel+bounces-570065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD3A6AB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C65188765A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD11EB5F0;
	Thu, 20 Mar 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESWSty1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397819D074;
	Thu, 20 Mar 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490015; cv=none; b=P38bGTgF5N8eMpEhDbmuVM+eG+Dg7XMTjSb4npir2RV9Q3JNn7wYcPfn3mOZNjDwQEqArB+cyTwlGRJjPw20bK3Sa+HAFTePQtQl3rD9dphIj5CLWAbTSLbwS7IQvfmfZiionaa6VrHLcOBApFBIltPzR0S/wmxZBaXKFOWNSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490015; c=relaxed/simple;
	bh=RjyJtuow2YtDXYzaNkugeAaIcyRIfeznyBJyOoDhNnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKRMtINltaMWtZYXdk/TW0wmn2MDIhGr8eIOPJgl/9V/jISCJ345kli44K4DA9Jx4QYB0bZpTFJ3cyUWQFpmTU24/8UMkjj8KlxnNDh8ZdwegQ7QqusQxnwotdS9UgEH99//Y7mtd9Gc304r9Aaerc02zYOPPX7uNWZl56+IS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESWSty1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF9EC4CEDD;
	Thu, 20 Mar 2025 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490014;
	bh=RjyJtuow2YtDXYzaNkugeAaIcyRIfeznyBJyOoDhNnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESWSty1KgPSe/jOD7QJStmexHasg+g6Mli4HbB+50vF+HX4MfCGzWXqYpMD/UCNJF
	 1ytlYxxvxOSswV82lemdmVOIqovbZasJXAGeIWyE1rYwr4QEpe3UPVZtpLpKdky4ZA
	 mO9ge7QMx0FlcHn9qu6jKnuRV2iHlFwiwBFGxcS4q7c/mbw5yCEwcMlVY5bBbCCFbK
	 AEaIMnVRjfq0HvmfQyUu5RtgRpyVz9eAkHP49xSormhHdUQiwO6ZvTkPW8ejQ5hHUm
	 PoqSVXElN1TC6Z9SYkcaMn4nuE/dmoBhze/ftTo9TbtkWzcH/tQ0HoZqvTtgWh3a3/
	 Gmcnyd185TOGg==
From: SeongJae Park <sj@kernel.org>
To: Taotao Chen <chentaotao@didiglobal.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: simplify control flow in damon_register_ops()
Date: Thu, 20 Mar 2025 10:00:11 -0700
Message-Id: <20250320170011.42114-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z9vxcPCw8tDsjKw1@OneApple>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@ and linux-mm@ mailing lists.

Hello Taotao,

On Thu, 20 Mar 2025 18:44:00 +0800 Taotao Chen <chentaotao@didiglobal.com> wrote:

> The function logic is not complex, so using goto is unnecessary.
> Replace it with a straightforward if-else to simplify control flow
> and improve readability.

Good catch and nice cleanup, thank you!
> 
> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

