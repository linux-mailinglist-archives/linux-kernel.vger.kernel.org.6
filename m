Return-Path: <linux-kernel+bounces-174641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F078C120D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013D21F21BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3A16F27A;
	Thu,  9 May 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="CU2NyNob"
Received: from smtp2.tecnico.ulisboa.pt (smtp2.tecnico.ulisboa.pt [193.136.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E315E811;
	Thu,  9 May 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268958; cv=none; b=VXnLRVfl7c+8cfYr2QxLNkkiefSkP9ILBi+yAQdBhnN4dCpG9yMtgoPf94o0I8Guwnxut9BXaAgUOCUUWqm++hjZoO7vR16lwU+J7vlfhO2c3zc/o5gL5zOCbX4vPSPLnMshznLPBMlwruGC6D6uUe2OTJBP1t22W9yGfdiQTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268958; c=relaxed/simple;
	bh=0IwlJOke6CGpKn6GzMdc7ZgMSv9NEztsvyiYpNUTvoY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvrE3rj/y7OHn2Vs5qvcN1BQ22Aa15Mz9LoGLe4wAjt/+t5hvgr5b3XHCoEV4dXXxA/gjtLlK9Lu98MtfhwIxKEQzA+KxgnNaXXO2suESxhqe6VpdgYehNfPbgV90D+GL5CtRuzao1Dg87kSHL34cRTyS6MpgE1yxFo2dfk743I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=CU2NyNob; arc=none smtp.client-ip=193.136.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTP id 7245B24543D;
	Thu,  9 May 2024 16:27:50 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp2.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp2.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 7CMGq9N0DNpK; Thu,  9 May 2024 16:27:48 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTPS id DBA242453F5;
	Thu,  9 May 2024 16:27:47 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1715268468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOzTJIUOd/eGZ7Rkf6Lh1ZnSkkcXA6C+E/1fEogp20w=;
	b=CU2NyNob9VPf66D1AeOFrHBj6evmHMz4ShGTDidF7nPR0S6wHJ0CSbhlKQ9xZEVMOZtnnR
	Cq+1n+6remb86TsNHtIguzauh4Ild9wmhtJ8FFydY3pdx5PDMlyPvTHEOF7zGeCjMNhLHY
	1aCF2W4DbL1edcRa5086fFSJucJG1H8=
Received: from diogo-gram.home (unknown [IPv6:2a01:14:8070:dc60:4589:2164:1bc5:2670])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 4CBAC3600AE;
	Thu,  9 May 2024 16:27:47 +0100 (WEST)
Date: Thu, 9 May 2024 16:27:41 +0100
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	lk@c--e.de, u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: typec: ucsi_acpi: Add LG Gram quirk
Message-ID: <5fh2v2dcjjcgg3qgvbhlsf24kfigzzbv3sq5ykjuwyjodbqzsa@kf7crcyswm5y>
References: <5qc55gruhn4pmutiukohauki5dehba6n2k22jgvpt7i3hafkon@v2ng2a33o7vv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5qc55gruhn4pmutiukohauki5dehba6n2k22jgvpt7i3hafkon@v2ng2a33o7vv>

On Thu, May 09, 2024 at 12:50:36PM GMT, Diogo Ivo wrote:
> Some LG Gram laptops report a bogus connector change event after a
> GET_PDOS command for the partner's source PDOs, which disappears from
> the CCI after acknowledging the command. However, the subsequent
> GET_CONNECTOR_STATUS in ucsi_handle_connector_change() still reports
> this bogus change in bits 5 and 6, leading to the UCSI core re-checking
> the partner's source PDOs and thus to an infinite loop.
> 
> Fix this by adding a quirk that signals when a potentially buggy GET_PDOS
> command is used, checks the status change report and clears it if it is a
> bogus event before sending it to the UCSI core.
> 
> [Sending as RFC both to see if this is a good idea and so that more
> users can test it to gather all the models affected by this bug.]
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> ---

I just realized that I should be using the {set, test, clear}_bit()
functions in the patch I sent, sorry for that. With this in mind it
would still be good to hear what you think about it.

Best regards,
Diogo

