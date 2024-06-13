Return-Path: <linux-kernel+bounces-213675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35CE90789E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7235228476F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642A146008;
	Thu, 13 Jun 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFIsMXMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706317FD;
	Thu, 13 Jun 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297285; cv=none; b=LCqjRdkU2uhFmnzsLmbTHLJpCt6DGHyTPQmwVO+S9oGuaS7FFBdyPKTQGgQO5unPZLHbKY4/FghL6qkStCaVEAahS4fUlNGsOav8JQ2Bot4Je6EEIElkjktWQJngj4fWxMOAc65B/UbsAuy0fXCo9kAFaICROaDRlRaHOy2aRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297285; c=relaxed/simple;
	bh=AJl67d8slnynIjtfzAGyDRCCHUC9dNMUzxCpIOQc+nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1krORvCl8R6S5SRWxECjs/ytk8bQuN4/LxqJdE9lcdMKGlsQT6batiQ4DDyny/8vgfKy5v5HCPmoypgVRu+IDktzMY5LmEG0dHzi/Wet5kt9fcbaZViIbQy8IGBgJ1iDCKm1HQfA9nEfSg2cMRnWZMzv4w/PWSefDdjX8VRvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFIsMXMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A62C2BBFC;
	Thu, 13 Jun 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297285;
	bh=AJl67d8slnynIjtfzAGyDRCCHUC9dNMUzxCpIOQc+nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jFIsMXMsqyze/Z8v8/dCBH6z8+PH7v0VhR21enZw/mKLXpd2yA5UKmd9ZI+HmmHOr
	 SlS/6ZqRAW4O9bgxtS7vHQGsxDBZ4oyWpjTK9LGu7MrDOYhmLl6hR9DsJjPxcWbt17
	 jm7fV9vzwQ/Ht77V8LZikuWrBANBwzKZHiXgA1QnUwafXf9+gZGg2dGIZvdGh572nI
	 8u3i5uFK3JkwYfaOsmzE8HeUgpZrNXk84jgmjHfzD9cV8Z5vGeDsxWdLkKURfMp3B9
	 BJaqQV6OtfVwLFHf22SBJKPlh/3Si7zG2rqhnV4WsU8f+zm9AykHp+hDypM+FqhBSC
	 xzI6Zn5PMI42A==
From: Lee Jones <lee@kernel.org>
To: Patrick Gansterer <paroga@paroga.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>
References: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>
Subject: Re: (subset) [PATCH] backlight: lm3509_bl: Fix NULL vs IS_ERR()
 check in register() function
Message-Id: <171829728292.2711571.6119910061158578189.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 17:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 06 Jun 2024 16:10:23 +0300, Dan Carpenter wrote:
> The devm_backlight_device_register() doesn't return NULL, it returns
> error pointers.  Update the error checking to match.
> 
> 

Applied, thanks!

[1/1] backlight: lm3509_bl: Fix NULL vs IS_ERR() check in register() function
      commit: 90b7f2ead953aab5677ae8235d78841cee8fd13e

--
Lee Jones [李琼斯]


