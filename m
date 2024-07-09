Return-Path: <linux-kernel+bounces-245163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32AC92AF24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A2DB21DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45B12CD89;
	Tue,  9 Jul 2024 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LduwMObD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834F29CEA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500546; cv=none; b=Mfs38BbChZOmllXN+xmp/E3zOgL4U3rlHozPB8ptNscJ8Ch4oaDgWvNrBIfqOzC+oSVOXsqQ4Ks+CLa4qmhtqxkIPv2NXzZJatcmuPv9ajnPsb0pFA1kxlm/piDeB1e39dLkX9No2xpzLDFr9kaoOhE4yYyUrVZt9n4T0FVC+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500546; c=relaxed/simple;
	bh=ivLuqXEefH7TTXXO9crz1NwH+cfs5yLI0OGmlJ5dzko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzcO5OfdHH4MokC40q5lUNuohN60hMLmgJ4UbPfQ3aKEgwWlcc/13Quh26wq/8axhTnFC57oAJtSrbWfuKE7oN3D1zVjQZ116dkt9+Cwe17LL78Bw3mgTdcQIQPOTlQUFG4mNPSw406NGz3Ew5gIcX30mIdVWdgHZ0u6IsErWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LduwMObD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD42C4AF07;
	Tue,  9 Jul 2024 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720500545;
	bh=ivLuqXEefH7TTXXO9crz1NwH+cfs5yLI0OGmlJ5dzko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LduwMObDP68pChZmH3p7IbxApKlQBN8hd6RrihQvQH6yljth5m4UV2okR7czB8iRS
	 UdHAO3dfLVZW6CAqknWpiMUl+wrrkDq8IIKy/FcZ/3ywT6/T0uZEb5OsLTbhc1eZv1
	 U1c4D/1FGz6oh8arkbxWBqM1X2HdFL6lsf/+HMKEaindoqJzlbLO+tiyFg9R8PbOhS
	 SRrthF8eW4/zISHZqd3yNIe45fL0syp19+doHyL16rEq7vmPME+Cch2a38DgJU1d6y
	 1RKI7Rj8263nXUHfWN7xslhzTEjezuojZl0OlmpCS/lIQvZNcpbCQcpcBCgQHylkTR
	 Nb80kpTa6cepw==
From: Christian Brauner <brauner@kernel.org>
To: jlayton@kernel.org,
	jack@suse.cz,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: mqueue: remove assignment from IS_ERR argument
Date: Tue,  9 Jul 2024 06:48:56 +0200
Message-ID: <20240709-einige-geblasen-f28d67cb5b00@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708080404.3859094-1-nichen@iscas.ac.cn>
References: <20240708080404.3859094-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=brauner@kernel.org; h=from:subject:message-id; bh=ivLuqXEefH7TTXXO9crz1NwH+cfs5yLI0OGmlJ5dzko=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT1HLTsYjoQZRHll+/1yVVv5h6hvW5Zvs53HDdqi1/UW dsemuTXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGFFYwMW+bcczDlC+ov6XDn L9z5slm6b9pqq/r9P3K0t0zOfPgjkJHhqNOnt3tTQvtfbDDtXTv/hXHLp9+imQKXJ0xfUe2wW8O VHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 08 Jul 2024 16:04:04 +0800, Chen Ni wrote:
> Remove assignment from IS_ERR() argument.
> This is detected by coccinelle.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] ipc: mqueue: remove assignment from IS_ERR argument
      https://git.kernel.org/vfs/vfs/c/b80cc4df1124

