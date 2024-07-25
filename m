Return-Path: <linux-kernel+bounces-262141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D593C17B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6841F214EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C37199380;
	Thu, 25 Jul 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrCzP5Mk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E219938D;
	Thu, 25 Jul 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909569; cv=none; b=oovLI6qdGdLjSxOx/LrrIH+IXPVtzAAQKDBMuznmMHwEa+w/Dm8WP6+C8FVcbELjO1uqBK8KCEOS0ylPUqqG3gdK+hKIpxoslPiBX4YMZDZMD7sEhlxJbPg+UbYUIRGFbxQa9sa3ka9W/Kybk/lZ/W4YYhzWlHKdwJIVdw/xhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909569; c=relaxed/simple;
	bh=SvCZIbU8mvxMu+WBqkw9ZKqT51Wm9YdZ3pVAHRKa8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKqIpLokP38JxI2og3E+SBrv8pp+VlSGfYRmMftiryvvKRS5quub46NRiSzDpUY73Ekf3D9pf4x4fHna7C29OUFLUboohWIzsD8++2u0SGo+R431RbYaO5CbqvFLP3w5EyX97moxHGYnY9Za8UPLsHfxaoVYdtMhh4WgDTqO/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrCzP5Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C27C116B1;
	Thu, 25 Jul 2024 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721909568;
	bh=SvCZIbU8mvxMu+WBqkw9ZKqT51Wm9YdZ3pVAHRKa8q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrCzP5MkowpQuUmoteQtAweEDOkTmEjmdgTaxp+l0JlL6b/3OqfZXP7eDeJacnjEp
	 YYGSMyI/OYWGYiRZYF8XueViPEd8SIoglUtnxangEE1FOFDVExgwpishwk7GwsgbkG
	 gMTcNAc1IUlrh4s7x9z0ubzyc1Xk1+hgyPGRzFj6HcSIBNnwcML0fp2Hrb3lzztmz7
	 5364FdN52vyamT2CHNkws5h5gMe5/TXWDoB3F6ZIum0h3/CQJ+3gn51Xuz5fHKeiEZ
	 /OzJQr+KQT620RA5J7rQgQgsqSbF5k3mcC4AHP6LyikB50iNrtZ0ZSLm+Xburc8akx
	 L5/bEdZqG4JCg==
Date: Thu, 25 Jul 2024 14:12:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 15/25] rcu: Rename rcu_dynticks_eqs_online() into
 rcu_watching_online()
Message-ID: <ZqJBPTed7FgoJS9Q@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-16-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-16-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:15PM +0200, Valentin Schneider a �crit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

