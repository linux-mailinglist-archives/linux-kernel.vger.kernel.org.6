Return-Path: <linux-kernel+bounces-227802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D49156B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358C8283FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDE1A08A7;
	Mon, 24 Jun 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N10uO/wo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CE1A0721;
	Mon, 24 Jun 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255203; cv=none; b=b5Q+lNsEVQsxf0C7vi16PEGgPkPYW7LQAzXoqdN6XHIDcUlxGSS0jmjxmI2quFBB8IeHDm6mb12LcjZd3ez2K07BLJhPB+kwe1M05uycNYmDnIi7JxkOcIpLqrDwoceaTM87qWm0I23jz6xayAGTj02N5gGJzpfOrVUzSLReVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255203; c=relaxed/simple;
	bh=jAoRQzMIiJVMipHSFJFpwVQWrLjDFLWRCwgzcGreZdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsd2iC5iJJFrZ7WHrAey9A1xmnerjlRap3IACYFBTlqDakcxAtQCKq5YtFQPKVbIlLHRz0JzAbGguie2JB5d0OF8OjCmEiQhAFf8XukE9IrqMdWQL8QqbhoNRXVG3TlaJE43GSMbMfMIy+MEwc1qZQr8M7fmE/R42v4niONW2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N10uO/wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C611C4AF0A;
	Mon, 24 Jun 2024 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255203;
	bh=jAoRQzMIiJVMipHSFJFpwVQWrLjDFLWRCwgzcGreZdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N10uO/woyXoJi2a6SoCpIeCpqnqgNOSMamTR5++NTp4kwy6L81exBTKh3aUu+W489
	 lxY3eG5fSmcxnQp6e90vPPvNK/psC9sO8+n+jumGD+ATVzwFM1cfOtA7DYBTOIfbZ0
	 hXSwu/OgkxvbJgk+fdnbTrYV+eNmBuZPCJLlTPe2YklEraJ5N0Ala17udrnYEHqHiy
	 L5MXTjReS17MM5Ad8ULfCM+HANcXqZF09y8KMTVoI6ibUkr7rFz4i7PDFwnPbhevDe
	 nLtvMMn3cj94vV6WbcUaSmYxfCBTGau8W8AqjWuV9aCDBjJOVywbJhZxExI0DDw0GU
	 FR4ElqdA8Ev8A==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 4/7] Docs: Move clang-format from process/ to dev-tools/
Date: Mon, 24 Jun 2024 11:53:09 -0700
Message-Id: <20240624185312.94537-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'clang-format' is on 'Other material' section of 'process/index', but it
may fit more under 'dev-tools/' directory.  Move it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .clang-format                                             | 2 +-
 Documentation/{process => dev-tools}/clang-format.rst     | 0
 Documentation/dev-tools/index.rst                         | 1 +
 Documentation/process/4.Coding.rst                        | 2 +-
 Documentation/process/coding-style.rst                    | 2 +-
 Documentation/process/index.rst                           | 1 -
 Documentation/translations/it_IT/process/clang-format.rst | 2 +-
 Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
 Documentation/translations/zh_CN/process/4.Coding.rst     | 2 +-
 Documentation/translations/zh_CN/process/coding-style.rst | 2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst     | 2 +-
 Documentation/translations/zh_TW/process/coding-style.rst | 2 +-
 12 files changed, 10 insertions(+), 10 deletions(-)
 rename Documentation/{process => dev-tools}/clang-format.rst (100%)

diff --git a/.clang-format b/.clang-format
index ccc9b93972a9..252820d9c80a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -4,7 +4,7 @@
 #
 # For more information, see:
 #
-#   Documentation/process/clang-format.rst
+#   Documentation/dev-tools/clang-format.rst
 #   https://clang.llvm.org/docs/ClangFormat.html
 #   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
 #
diff --git a/Documentation/process/clang-format.rst b/Documentation/dev-tools/clang-format.rst
similarity index 100%
rename from Documentation/process/clang-format.rst
rename to Documentation/dev-tools/clang-format.rst
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index efa49cdc8e2e..a5f241cf0c02 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -16,6 +16,7 @@ Documentation/dev-tools/testing-overview.rst
 
    testing-overview
    checkpatch
+   clang-format
    coccinelle
    sparse
    kcov
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index c2046dec0c2f..80bcc1cabc23 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -63,7 +63,7 @@ these rules, to quickly re-format parts of your code automatically,
 and to review full files in order to spot coding style mistakes,
 typos and possible improvements. It is also handy for sorting ``#includes``,
 for aligning variables/macros, for reflowing text and other similar tasks.
-See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
+See the file :ref:`Documentation/dev-tools/clang-format.rst <clangformat>`
 for more details.
 
 Some basic editor settings, such as indentation and line endings, will be
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 7e768c65aa92..04f6aa377a5d 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -732,7 +732,7 @@ these rules, to quickly re-format parts of your code automatically,
 and to review full files in order to spot coding style mistakes,
 typos and possible improvements. It is also handy for sorting ``#includes``,
 for aligning variables/macros, for reflowing text and other similar tasks.
-See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
+See the file :ref:`Documentation/dev-tools/clang-format.rst <clangformat>`
 for more details.
 
 Some basic editor settings, such as indentation and line endings, will be
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index fb089bf9d6a8..1827e73f6376 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -113,7 +113,6 @@ lack of a better place.
 .. toctree::
    :maxdepth: 1
 
-   clang-format
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/process/clang-format.rst
index 29f83c198025..6fab07772da0 100644
--- a/Documentation/translations/it_IT/process/clang-format.rst
+++ b/Documentation/translations/it_IT/process/clang-format.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/clang-format.rst <clangformat>`
+:Original: :ref:`Documentation/dev-tools/clang-format.rst <clangformat>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_clangformat:
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index b5a84df44cea..025223be9706 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -754,7 +754,7 @@ código automáticamente, y revisar archivos completos para detectar errores
 de estilo del código, errores tipográficos y posibles mejoras. También es
 útil para ordenar ``#includes``, para alinear variables/macros, para
 redistribuir texto y otras tareas similares. Vea el archivo
-:ref:`Documentation/process/clang-format.rst <clangformat>` para más
+:ref:`Documentation/dev-tools/clang-format.rst <clangformat>` para más
 detalles.
 
 10) Archivos de configuración de Kconfig
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index 7cac9424f5d5..4cc35d410dbc 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -54,7 +54,7 @@
 注意您还可以使用 ``clang-format`` 工具来帮助您处理这些规则，快速自动重新格式
 化部分代码，和审阅完整的文件以发现代码样式错误、拼写错误和可能的改进。它还
 可以方便地排序 ``#includes`` 、对齐变量/宏、重排文本和其他类似任务。有关详细
-信息，请参阅文档 :ref:`Documentation/process/clang-format.rst <clangformat>`
+信息，请参阅文档 :ref:`Documentation/dev-tools/clang-format.rst <clangformat>`
 
 抽象层
 ******
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index 3bc2810b151d..10b9cb4f6a65 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -654,7 +654,7 @@ Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
 请注意，您还可以使用 ``clang-format`` 工具帮助您处理这些规则，快速自动重新格
 式化部分代码，并审阅整个文件以发现代码风格错误、打字错误和可能的改进。它还可
 以方便地排序 ``#include`` ，对齐变量/宏，重排文本和其他类似任务。
-详见 Documentation/process/clang-format.rst 。
+详见 Documentation/dev-tools/clang-format.rst 。
 
 
 10) Kconfig 配置文件
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index bdd2abe4daf4..e90a6b51fb98 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -57,7 +57,7 @@
 注意您還可以使用 ``clang-format`` 工具來幫助您處理這些規則，快速自動重新格式
 化部分代碼，和審閱完整的文件以發現代碼樣式錯誤、拼寫錯誤和可能的改進。它還
 可以方便地排序 ``#includes`` 、對齊變量/宏、重排文本和其他類似任務。有關詳細
-信息，請參閱文檔 :ref:`Documentation/process/clang-format.rst <clangformat>`
+信息，請參閱文檔 :ref:`Documentation/dev-tools/clang-format.rst <clangformat>`
 
 抽象層
 ******
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index c7ac504f6f40..311c6f6bad0b 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -657,7 +657,7 @@ Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
 請注意，您還可以使用 ``clang-format`` 工具幫助您處理這些規則，快速自動重新格
 式化部分代碼，並審閱整個文件以發現代碼風格錯誤、打字錯誤和可能的改進。它還可
 以方便地排序 ``#include`` ，對齊變量/宏，重排文本和其他類似任務。
-詳見 Documentation/process/clang-format.rst 。
+詳見 Documentation/dev-tools/clang-format.rst 。
 
 
 10) Kconfig 配置文件
-- 
2.39.2


