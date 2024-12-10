Return-Path: <linux-kernel+bounces-440172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BE9EB9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A261163CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D468214226;
	Tue, 10 Dec 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZFVSy9w"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF09214224;
	Tue, 10 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856829; cv=none; b=YA1R29W1wb9qPwmPlJ3R/3D3/zKZSdsRfJXTpQ403QYTjgqRA6BPNLbPBTQHPDXKXALLVG5Gc/6W2O73+RwvzGNVRbT98cvPw1axmBoYx7VM0e0mEw844DkFzPE3myy5bEx+SOj637osSnrhs1EJZeZ5GZNipd9F5FQa8dskdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856829; c=relaxed/simple;
	bh=PJXFSsciN5SLQAl4tzyaUy6AeTfDpRNKixwoQTyFjDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOjOrOMfJWkHTKlTADdL+D3+i2RBeZzcDYAZ5hGTG1ugRkYZeCJuoSA9Uw0PkbcKzvPi9Kpl2l+Og1zrX6lkPWjRYQocNzV4x+7bu0OcLFb1Wvio92qQK87RS0lVsAl5qVKBNahAcN9+i7y5HnmecpK0aKvhpZeGKxQsEMkEPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eZFVSy9w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fPKYW7SKQSMpOcTbW3Ejkggo5Mw0hB3RvKktjApo6H4=; b=eZFVSy9wUsE0MMiHjRJyqjhzRO
	HN3ZZ5KoHcNEGHBW+NyMe+W8Bjwz+vBFXjsmT5j2LNgaoAWBvxcc5LfwRf5GZ0k9jB60lrMrLc9di
	rEMzIr3TmHifsf1c5XS8GBKgEK06ch9JVKSOHYoFE/Hiav6gtWlHFSGafr0hKfjgXvGlxdpaCeC7d
	Bc5JncuXfpxl+jn/dJM9WbUOwoN+BgKOfuFtjbSoM08VuRnLFFAPehIQ9j/wEMBSCxtQ6Y/p0r7pS
	CSzCLTdszMBaWaRXiU2fy7XcyXwS51vYp/nrw4VAqIrU8Lr+A/hh7/QlRUaDtRiW2gRNmgFpE97De
	99lZp2rw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tL5MZ-0000000B0tB-1fc4;
	Tue, 10 Dec 2024 18:53:39 +0000
Date: Tue, 10 Dec 2024 18:53:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
Message-ID: <Z1iOM9o6mYyAErdX@casper.infradead.org>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>

On Tue, Dec 10, 2024 at 08:04:15PM +0900, Akira Yokosawa wrote:
> +++ b/scripts/kernel-doc
> @@ -267,7 +267,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
>  my $doc_inline_end = '^\s*\*/\s*$';
>  my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
>  my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
> -my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
> +my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*;';

Could we simplify this?  We don't seem to treat export_symbol and
export_symbol_ns differently, so why not catch all possibilities with
one regex?

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f66070176ba3..de22f88f7a35 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -266,8 +266,7 @@ my $doc_inline_start = '^\s*/\*\*\s*$';
 my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
-my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
-my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
+my $export_symbol = '^\s*EXPORT_SYMBOL[_A-Z]*\s*\(\s*(\w+)\s*\)\s*;';
 my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
 
@@ -2024,12 +2023,8 @@ sub process_export_file($) {
 
     while (<IN>) {
         if (/$export_symbol/) {
-            next if (defined($nosymbol_table{$2}));
-            $function_table{$2} = 1;
-        }
-        if (/$export_symbol_ns/) {
-            next if (defined($nosymbol_table{$2}));
-            $function_table{$2} = 1;
+            next if (defined($nosymbol_table{$1}));
+            $function_table{$1} = 1;
         }
     }
 

