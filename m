Return-Path: <linux-kernel+bounces-422544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC49D9AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6367282B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7D1D5CF2;
	Tue, 26 Nov 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXWnA7Ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516211187;
	Tue, 26 Nov 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637025; cv=none; b=GhWmr/JRqX1QEAETZyUv40fBnQi8ZRgpa/cN0GrvDL3zZjA+QZQEZyKyD+uWRKXQtqk5TwB//1XTtGo4qpf/8v35yUOTV90FNT0P4/PyftE7vUHXxgxYwJSeGpp7uY9e+qSb5qfAQ3ENb7vw7P4dmybBM3Cax4r/lWA0Cjq6bDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637025; c=relaxed/simple;
	bh=zG/GKhmQ0SME1ih5rGNq7e6qt191U2i/0uLyeG5bYCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVnFVryrBKqIkiNuP6qJU2PE65Vmm4CgbbyqFDSuL+6QaMQb9DXuhLOAnWq9WfG9WtvxCVcZ9dqjoTOeb625cLTYtjCnBp16K/NL8Jg+BzjDniOYPJ8qRecSo1AozNETRkESqA08ky+6qGzS22bNZKDj2Kci283HWggTeu37o/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXWnA7Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DFDC4CECF;
	Tue, 26 Nov 2024 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732637025;
	bh=zG/GKhmQ0SME1ih5rGNq7e6qt191U2i/0uLyeG5bYCk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cXWnA7TsfevlpGIybYinfKUSFECyHMGL+LCoFN9Hz9nKEr/BcHzMxwMijvJoxH92R
	 +5Phdum6Dff3EBf//nzNvCTzFMdTM7z8af5tTKRWSVSMOgdJorr3+cvdYBuB67p/Kk
	 0IFSAJX553+QfKMkE5HBrZi7Sy6DIfLT/zm+XqjsencBfcEnNLy7fT/7zvQTTER1Nf
	 Y/ZLmp/8NIvTo7Of54Jm6caty37zHtb4PTGOXqvyTGj7YK1p5vA08p+PEQZN21jcJD
	 DxcXzl+q3M041D+XwqgPelG1ODGEnLxKb/2fFOtEib4PWv11gUpcF9efn+8aZxQQik
	 YNGT+VP1OcIjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 930C2CE0C3C; Tue, 26 Nov 2024 08:03:44 -0800 (PST)
Date: Tue, 26 Nov 2024 08:03:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, boqun.feng@gmail.com,
	dhowells@redhat.com, dlustig@nvidia.com, frederic@kernel.org,
	hernan.poncedeleon@huaweicloud.com, j.alglave@ucl.ac.uk,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
	parri.andrea@gmail.com, peterz@infradead.org,
	quic_neeraju@quicinc.com, stern@rowland.harvard.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <54e719ea-e7de-430e-8c23-29d9b184fe9c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
 <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
 <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>
 <245e4781-80b2-4e21-b4de-51ffeac9cc39@paulmck-laptop>
 <02537f27-ac3b-4e2e-80a2-ad57230ac478@paulmck-laptop>
 <94ec40b6-79d7-4d23-97c0-951a5faac9c8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ec40b6-79d7-4d23-97c0-951a5faac9c8@huaweicloud.com>

On Tue, Nov 26, 2024 at 04:25:46PM +0100, Jonas Oberhauser wrote:
> 
> 
> Am 11/18/2024 um 4:05 PM schrieb Paul E. McKenney:
> > On Fri, Nov 08, 2024 at 10:35:24AM -0800, Paul E. McKenney wrote:
> >>
> > > And now you know.  ;-)
> > 
> > if it is important to
> > get the first three into the current merge window, please rebase them
> > to mainline some time this week
> 
> > Over to you!
> 
> Luckily there's no need and we can wait until a new herd release.

Sounds good, and here is hoping for sooner rather than later.

							Thanx, Paul

