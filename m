Return-Path: <linux-kernel+bounces-319470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732596FCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BB01F253E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196E1D6792;
	Fri,  6 Sep 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MUNpLXws"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA92188A31
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655939; cv=none; b=iC9WcloAY63F+q4S7gdTE5DgxgdhAuY9g/vHxd97X5bggRyWbfOtAs+UPMVZdn3h6AsZB0O/QEdcxldip32qZQJ051uCMgd2PAxGuGvoY9H+bGmoeVUzTCHczZGfPBzvWw7gdgtIHwKi0ZUHI8FvNMeUXIYMIaLaEfSGRaSILus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655939; c=relaxed/simple;
	bh=k6wlknzFNe1EaXkaq+c4F/UHuw+NkLv4xBB96Ju3wvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMsZbydRXt8Dbt4leEYIayvzYNkf9EYcm6aGGO3Nnd9QjigoWn+sroW+frXtZMrjpFigPpkNaq742O9AdhGRu5qzPyBenGPRScg2xAJ/otHrO6GB+Hln3KX8M+hsDqSCDK8/Nf9PS2H2/mDFqMXVoClQW66GmICX7QaeCpreNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MUNpLXws; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 486Kq2dM018847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 16:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725655924; bh=k6wlknzFNe1EaXkaq+c4F/UHuw+NkLv4xBB96Ju3wvU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MUNpLXwsnXBAWb+44Myls1LIVFFuBlPWFeLrHzJ0o4NGyKaJyMJSPWljaa/DpWyqW
	 oFXvbYBltdLO/1ROZDP06r8LwckBJOrbHMOphRFsKGmvjUcIveefBeHTHQ86OBWzaS
	 6mW1vnSSziw07nAxGaCc3qu7RyWYzAcrRlwfI7XSEUHcx6+93QNhhJpE4bdHR7kYEu
	 epkg8XkDrGO4jC+0PQExFXXD259+hRdnlK+JCAP7NwomzZxHJRUzkvqD7csz5JgIQy
	 7pVTmsTj9DEa0Mf6XkyBn7FJQHx5xhDDH7gk3+keBoEkVuh+RPDgMn7TJRPAAPIhQV
	 4NojT1uVmEj3Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7D8FA15C1909; Fri, 06 Sep 2024 16:52:02 -0400 (EDT)
Date: Fri, 6 Sep 2024 16:52:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes
Message-ID: <20240906205202.GX9627@mit.edu>
References: <20240906195400.39949-1-dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906195400.39949-1-dennis.lamerice@gmail.com>

On Fri, Sep 06, 2024 at 03:53:52PM -0400, Dennis Lam wrote:
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


