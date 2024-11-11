Return-Path: <linux-kernel+bounces-404042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6ED9C3E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45BE1C21717
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C919CC28;
	Mon, 11 Nov 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0RwYjuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328055C29;
	Mon, 11 Nov 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328215; cv=none; b=OFH0OMIOb20YUFo3VzE7dJgmcbwHMxY6Ba8CT1EqLtwWU3uKl8DShOF78b7y6GPPRYqXxFh9u78CkVV7GoSTo7t8NbUPhOjnJVsT0fdlTdiyeq7FvoRneK9VEaw29hqcwXkGGdfJLQx4qYUgxRbHf56x+OgglpN6lDAMvZ43HHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328215; c=relaxed/simple;
	bh=1EQ72/xXKMzO8c3aOGw5ISYdpzMgvllLBlkGNTaGA8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSOngQVcpxBlMuy9IhOtPZOXtyKJWYgmKUHy/b53kMLVK1bCbG/mZzP78IkQPwJgW7BQlCZycDDD2FYLatuEpGjAqErOTcNWCDKgZLz0LMjRDViKqTkG6cF+I+qZAgdrCC+qvawC5kWstKKJu72h4ntMq0OZn7qqOTKW1oVJ3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0RwYjuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD01C4CED5;
	Mon, 11 Nov 2024 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731328214;
	bh=1EQ72/xXKMzO8c3aOGw5ISYdpzMgvllLBlkGNTaGA8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h0RwYjuuno1d5+Uzi8y5LDbxlnP6UDV1OYCR0cePnTQZyd6sJsuQxbU2m0A6Q6A57
	 lDD+XlsDMQT3hKob/m62dlVg/5G79wytKBa/u0oTGU2XQ/8vhcRUSlou/YRAMj6EyB
	 lWbW+YfW4UBxVgAHJnU6fejKKwzr6ZyadAYSQY+rdBd2LSmeIGwOA+cCTzsWM/tKiY
	 879OOoKo4X0ZLjgF5jQ7yGQuvEgOPgxYZ7TCdfFR/6UkTheWEqZURKMSWNboQADZ5X
	 4yq+pELdvczmkDZOSBaeU0ZFzt3iXlZ9Y7nS+WNLQw/m21EwpEUfVFlDolQdJvcOjx
	 NaSAPpN8a48Dg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <dakr@redhat.com>,  <airlied@redhat.com>,
  <miguel.ojeda.sandonis@gmail.com>,  <wedsonaf@gmail.com>
Subject: Re: [PATCH 0/2] Add dma coherent allocator abstraction
In-Reply-To: <20241023113309.1724992-1-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Wed, 23 Oct 2024 14:32:49 +0300")
References: <gOYx0SWgtHGMFdeca-cxwYWFvr0hwCWCLCyLndrSSh8p9dU1wFSDL3ssAL-zaCfEbUyQ49dpsn8XaGfSamF-Sw==@protonmail.internalid>
	<20241023113309.1724992-1-abdiel.janulgue@gmail.com>
Date: Mon, 11 Nov 2024 13:14:48 +0100
Message-ID: <874j4et1af.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> This series adds support for the dma coherent allocator. This is based
> on code developed by Andreas Hindborg for the rnvme driver.

I was not the original author, I just rebased the patches for a few years. I
believe Wedson was the original author. I also did not add my signed-off-by to
this.


Best regards,
Andreas Hindborg




