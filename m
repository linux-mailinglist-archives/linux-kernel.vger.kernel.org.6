Return-Path: <linux-kernel+bounces-423530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCC9DA8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8281F282618
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F41FCFD3;
	Wed, 27 Nov 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndtL5tA1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379811FE449
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714995; cv=none; b=CdWUxgGbwW9ixKj9WusNsOdkptTqSB2u+0m1LYIDaFzxiU8nuRSAUhKSmOwzySIeekDYBa/4fBhPQknuSkEg1aiso/dqARbvwHgirZTUQLXSjNbF7v54mTvvErJtaJQFiL7RlHKceDHUIQBlNmxjYObNw3qaOWf9syhI63Oc4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714995; c=relaxed/simple;
	bh=DLkjziN79QL8lyYnpS+eq3WKuIQ9MNA9OHMlkX9yOnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stfEbNH76ujF5wfY926F1h+Gj5SCzDxgPrxTpokuNFuX9m84gGhMTJA38hMOgXl7VdKPqQRLAzz8uE7KCWw2Oy5ixdfjglOnJ9zUIql2Lc/6yl0W0J0bLMemvwqxzIQn0ycqece+64Dt6xdBwGpV75LvU9bZLdxkbzPjAd4WDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ndtL5tA1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38241435528so4271112f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714989; x=1733319789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7njX2qcYZvO6vOSLv4oNfTTNGnncqtHXP/PHkDETIWA=;
        b=ndtL5tA1X7PVwATf3f/NUAnlzE34wMKRzMssjeEOH9AF8lmtEpM3GUR97qbs+S19xi
         dsy2tDpwc94/QyZVCi4NcneILLOPuBC7TcwND3FfgCUmHqoEHteMstzc/uiMPaQdaTWf
         svdVvC2a18jDuIAyKkLYPY3motQt0RA/ZriJW9HaYJoOEYzCKIGkbJjG3DvlA4/bkQZ2
         /ZE7lI5NDC+qJYS/wMdCOQrcb4TuVXxNScAUm85Xk0JFR0cxP7jbYAfODE3RI+/4KvAv
         wqmt5l8nPXMT/PQfSWo5S1qQqW+Oce/nHMrToxV9niygp8S6xNyIlqJVsPklDUEv5rk/
         hwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714989; x=1733319789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7njX2qcYZvO6vOSLv4oNfTTNGnncqtHXP/PHkDETIWA=;
        b=SBJ01GSNNmJEMRNgLzwScqmJ0/gutS89ga3cAU20zAenL984hrm4a/rJvQw95m6lLn
         Io0LgvVKFuE+Jcu0rZwRC+jdFZmHiDmeununm3PGW1khPi2M0uVrOr9oqXBTBet0ywWZ
         F860U9RM9Gqjg4/s8d+8c8lOWUaEs+neQcZdwcIt0IepbI3qGykUhHAZml9rRsP8FmyV
         bnrAf6xCcsdZOWdKPZ93CnDu4lxv+DQeUrvCcb/dUfqiNKzUCiBrRSoMDz38yhpBcVt6
         sxzXNzDMk9VixZOVlxndIU6ymMMylyLog/mzOK13+B4Zboh6qpz9yhrSOmzU0TZPi+2g
         6HJw==
X-Forwarded-Encrypted: i=1; AJvYcCUiTfRZBWAiX4dwkD0+FIRMhedO20wlr5WmMfaKkfC1/MoDfNjXVVvhX/qTK97ywSUxpqcw7sqgIwJRfW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtJDz8wUuaqbmpPD+LmeV68gc6CNa2EZPWHfnJrpcbH6Zm6yL
	ZF41X/fRLVb20/x9pwNJRp2Pd8rIrSMTWJr/56j5DjhPkIf9kH+vrkApIYAXKk0=
X-Gm-Gg: ASbGncscPYN3+eY4pj3vxJqMjMVaUSFx0TfS0mr5fNSeCAHmtV848Ox6rY81d/OgLpY
	tKjqsPIfkG08aYCbwnndOEKixmvsD8kHdVXo0y4sz6e09Qhgu2RwMngBCnOfgxq1bP7afzqxjT+
	mcSEblB7LfYrr/KkEQ/cr1kWWtci6qsF6U1J4cFxc2HAPX6QmMauZj6c45v5/JCVuFwp47tg+Hn
	uPvX4dmVjv3RAjaN6YW2zWHRl23Iq7qbGHyx50cdm6cHD/0YQK0
X-Google-Smtp-Source: AGHT+IHtYk4lGlVanH8Zl/bhihmPXZaX9Uid8tNSLVUiXA+XljSYVslcRPdWrI2XiTM3QzDUET83UQ==
X-Received: by 2002:a05:6000:4818:b0:382:5af:e990 with SMTP id ffacd0b85a97d-385c6ee221amr2393086f8f.49.1732714989351;
        Wed, 27 Nov 2024 05:43:09 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:08 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 9/9] Documentation: coresight: Docs for configuration table load
Date: Wed, 27 Nov 2024 13:42:56 +0000
Message-Id: <20241127134256.2254851-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127134256.2254851-1-mike.leach@linaro.org>
References: <20241127134256.2254851-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation covering the updates that allow
configuration tables to be loaded and unloaded via configfs,
along with the demonstration programs in tools/coresight.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../trace/coresight/coresight-config.rst      | 287 ++++++++++++++++--
 1 file changed, 264 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
index 6d5ffa6f7347..235cc6443a86 100644
--- a/Documentation/trace/coresight/coresight-config.rst
+++ b/Documentation/trace/coresight/coresight-config.rst
@@ -109,20 +109,20 @@ Operation
 
 The following steps take place in the operation of a configuration.
 
-1) In this example, the configuration is 'autofdo', which has an
-   associated feature 'strobing' that works on ETMv4 CoreSight Devices.
+1) In this example, the configuration is ``autofdo``, which has an
+   associated feature ``strobing`` that works on ETMv4 CoreSight Devices.
 
-2) The configuration is enabled. For example 'perf' may select the
+2) The configuration is enabled. For example ``perf`` may select the
    configuration as part of its command line::
 
     perf record -e cs_etm/autofdo/ myapp
 
-   which will enable the 'autofdo' configuration.
+   which will enable the ``autofdo`` configuration.
 
 3) perf starts tracing on the system. As each ETMv4 that perf uses for
    trace is enabled,  the configuration manager will check if the ETMv4
    has a feature that relates to the currently active configuration.
-   In this case 'strobing' is enabled & programmed into the ETMv4.
+   In this case ``strobing`` is enabled & programmed into the ETMv4.
 
 4) When the ETMv4 is disabled, any registers marked as needing to be
    saved will be read back.
@@ -136,18 +136,18 @@ Viewing Configurations and Features
 The set of configurations and features that are currently loaded into the
 system can be viewed using the configfs API.
 
-Mount configfs as normal and the 'cs-syscfg' subsystem will appear::
+Mount configfs as normal and the ``cs-syscfg`` subsystem will appear::
 
     $ ls /config
     cs-syscfg  stp-policy
 
-This has two sub-directories::
+This has two sub-directories, with the load and unload attribute files::
 
     $ cd cs-syscfg/
     $ ls
-    configurations  features
+    configurations features load  unload
 
-The system has the configuration 'autofdo' built in. It may be examined as
+The system has the configuration ``autofdo`` built in. It may be examined as
 follows::
 
     $ cd configurations/
@@ -162,7 +162,7 @@ follows::
     $ cat feature_refs
     strobing
 
-Each preset declared has a 'preset<n>' subdirectory declared. The values for
+Each preset declared has a ``preset<n>`` subdirectory declared. The values for
 the preset can be examined::
 
     $ cat preset1/values
@@ -170,7 +170,7 @@ the preset can be examined::
     $ cat preset2/values
     strobing.window = 0x1388 strobing.period = 0x4
 
-The 'enable' and 'preset' files allow the control of a configuration when
+The ``enable`` and ``preset`` files allow the control of a configuration when
 using CoreSight with sysfs.
 
 The features referenced by the configuration can be examined in the features
@@ -210,18 +210,18 @@ Using Configurations in perf
 ============================
 
 The configurations loaded into the CoreSight configuration management are
-also declared in the perf 'cs_etm' event infrastructure so that they can
+also declared in the perf ``cs_etm`` event infrastructure so that they can
 be selected when running trace under perf::
 
     $ ls /sys/devices/cs_etm
     cpu0  cpu2  events  nr_addr_filters		power  subsystem  uevent
     cpu1  cpu3  format  perf_event_mux_interval_ms	sinks  type
 
-The key directory here is 'events' - a generic perf directory which allows
+The key directory here is ``events`` - a generic perf directory which allows
 selection on the perf command line. As with the sinks entries, this provides
 a hash of the configuration name.
 
-The entry in the 'events' directory uses perfs built in syntax generator
+The entry in the ``events`` directory uses perfs built in syntax generator
 to substitute the syntax for the name when evaluating the command::
 
     $ ls events/
@@ -229,7 +229,7 @@ to substitute the syntax for the name when evaluating the command::
     $ cat events/autofdo
     configid=0xa7c3dddd
 
-The 'autofdo' configuration may be selected on the perf command line::
+The ``autofdo`` configuration may be selected on the perf command line::
 
     $ perf record -e cs_etm/autofdo/u --per-thread <application>
 
@@ -246,7 +246,7 @@ Using Configurations in sysfs
 Coresight can be controlled using sysfs. When this is in use then a configuration
 can be made active for the devices that are used in the sysfs session.
 
-In a configuration there are 'enable' and 'preset' files.
+In a configuration there are ``enable`` and ``preset`` files.
 
 To enable a configuration for use with sysfs::
 
@@ -256,13 +256,13 @@ To enable a configuration for use with sysfs::
 This will then use any default parameter values in the features - which can be
 adjusted as described above.
 
-To use a preset<n> set of parameter values::
+To use a ``preset<n>`` set of parameter values::
 
     $ echo 3 > preset
 
 This will select preset3 for the configuration.
 The valid values for preset are 0 - to deselect presets, and any value of
-<n> where a preset<n> sub-directory is present.
+<n> where a ``preset<n>`` sub-directory is present.
 
 Note that the active sysfs configuration is a global parameter, therefore
 only a single configuration can be active for sysfs at any one time.
@@ -278,9 +278,28 @@ Creating and Loading Custom Configurations
 ==========================================
 
 Custom configurations and / or features can be dynamically loaded into the
-system by using a loadable module.
+system by using a loadable module, or by loading a configuration table
+through in configfs.
 
-An example of a custom configuration is found in ./samples/coresight.
+Loaded configurations can use previously loaded features. The system will
+ensure that it is not possible to unload a feature that is currently in
+use, by enforcing the unload order as the strict reverse of the load order.
+
+
+Using a Loadable Module
+-----------------------
+
+A new configuration or set of features can be created using the internal
+structures used in the drivers, by writing a loadable module that defines
+the configuration, and loading this into the kernel at runtime.
+
+Creating a custom configuration in this way requires the user to compile the
+module for the specific kernel in use, which limits portability.
+
+Module Example
+~~~~~~~~~~~~~~
+
+An example of a custom configuration module is found in ``./samples/coresight``.
 
 This creates a new configuration that uses the existing built in
 strobing feature, but provides a different set of presets.
@@ -289,6 +308,228 @@ When the module is loaded, then the configuration appears in the configfs
 file system and is selectable in the same way as the built in configuration
 described above.
 
-Configurations can use previously loaded features. The system will ensure
-that it is not possible to unload a feature that is currently in use, by
-enforcing the unload order as the strict reverse of the load order.
+The file ``coresight-cfg-sample.c`` contains the configuration and module
+initialisation code needed to create the loadable module.
+
+This will be built alongside the kernel modules if selected in KConfig.
+(select ``CONFIG_SAMPLE_CORESIGHT_SYSCFG``).
+
+
+Using a Configuration Table File
+--------------------------------
+
+Configurations and features can also be dynamically loaded at runtime
+using a compact binary table format described below.
+
+Upon load, this table is validated, expanded into the internal structures
+needed for load into the CoreSight subsystem, and loaded into the relevant
+CoreSight devices.
+
+There are additional attributes in the cs-syscfg directory - ``load_table``
+and ``unload_last_table`` that can be used to load and unload configuration
+tables.
+
+As described above, in order to respect configuration dependencies, unload
+order is scrictly enforced to be the reverse of load order.
+
+Load and unload cannot be done if trace is in progress using a configuration.
+
+To load, 'cat' the table file into the load attribute::
+
+    $ ls /config/cs-syscfg
+    configurations features  load_table  show_last_load  unload_last_table
+    $ cat example1.cscfg > /config/cs-syscfg/load_table
+    $ ls /config/cs-syscfg/configurations/
+    autofdo  autofdo3
+
+``unload_last_table`` can be used to unload the last loaded configuration,
+but only if this was loaded as a configuration table.
+
+To unload, write a non-zero value to ``unload_last_table``. This will unload
+the last loaded table - unless another configuration or feature has been
+loaded as a loadable module after the last table load::
+
+    $ echo 1 > /config/cs-syscfg/unload_last_table
+    ls /config/cs-syscfg/configurations/
+    autofdo
+
+The type of the last loaded configuration can be determined by reading the
+``show_last_load`` attribute::
+
+    $ cat /config/cs-syscfg/show_last_load
+    load name: autofdo3
+    load type: Runtime Dynamic table load
+    (configurations:  autofdo3 )
+    (features:  None )
+
+This shows the key elements of the loaded configuration - the type of load,
+load name, and any configurations and features loaded by the table.
+
+Unload will fail if the last loaded item was not a dynamic loaded table.
+When using ``show_last_load`` a non table load will show::
+
+    cat /config/cs-syscfg/show_last_load
+    load name: [Not Set]
+    load type: Loadable module
+
+
+Generation tools and table examples
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``./tools/coresight`` directory contains example programs to generate and
+read and print binary configuration table files.
+
+Building the tools creates the ``coresight-cfg-file-gen`` program that will
+generate a configuration binary ``example1.cscfg`` that can be loaded into the
+system using configfs. The configuration declared in the source file
+``coresight-cfg-example1.c`` is named ``autofdo3`` - the name that will be used
+once loaded.
+
+The source files ``coresight-cfg-bufw.h`` and ``coresight-cfg-bufw.c`` provide a
+standard function to convert a configuration declared in 'C' into the correct
+binary buffer format. These files can be re-used to create new custom
+configurations. Alternatively, additional examples can be added to the
+``coresight-cfg-file-gen`` program::
+
+    $ ./coresight-cfg-file-gen
+    Coresight Configuration file Generator
+
+    Generating example1 example
+    Generating example2 example
+
+The program ``coresight-cfg-file-read`` can read back and print a configuration
+binary. This is built using the file reader from the driver code
+(``coresight-config-file.c``), which is copied over into ``./tools/coresight`` at
+build time.::
+
+    ./coresight-cfg-file-read example1.cscfg
+    CoreSight Configuration file reader
+    ============================================
+
+    Configuration 1
+    Name:- autofdo3
+    Description:-
+    Setup ETMs with strobing for autofdo
+    Supplied presets allow experimentation with mark-space ratio for various loads
+
+    Uses 1 features:-
+    Feature-1: strobing
+
+    Provides 4 sets of preset values, 2 presets per set
+    set[0]: 0x7d0, 0x64,
+    set[1]: 0x7d0, 0x3e8,
+    set[2]: 0x7d0, 0x1388,
+    set[3]: 0x7d0, 0x2710,
+
+    ============================================
+    File contains no features
+
+
+CoreSight Configuration Table Format
+------------------------------------
+
+The file format is defined in the source file ``coresight-config-table.h``
+
+The source reader and generator examples use/produce a table in this format,
+as a binary file.
+
+This arrangement is reproduced below:-
+
+Overall Table structure
+~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_header]  // Mandatory
+   [CONFIG_ELEM]*        // Optional - multiple, defined by cscfg_table_header.nr_configs
+   [FEATURE_ELEM]*       // Optional - multiple, defined by cscfg_table_header.nr_features
+
+Table is invalid if both [CONFIG_ELEM] and [FEATURE_ELEM] are omitted.
+
+A table that contains only [FEATURE_ELEM] may be loaded, and the features used
+by subsequently loaded files with [CONFIG_ELEM] elements.
+
+Element Name Strings
+~~~~~~~~~~~~~~~~~~~~
+
+Configuration name strings are required to consist of alphanumeric characters and '_' only. Other special characters are not permitted.
+
+For example ``my_config_2`` is a valid name, while ``this-bad-config#5`` will not work.
+
+This is in order to comply with the requirements of the perf command line.
+
+It is recommended that Feature and Parameter names use the same convention to allow for future enhancements to the command line syntax.
+
+CONFIG_ELEM element
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_header]               // header length value to end of feature strings.
+   [cscfg_table_elem_str]                  // name of the configuration.
+                                           // (see element string name requirements)
+   [cscfg_table_elem_str]                  // description of configuration.
+   [u16 value](nr_presets)                 // number of defined sets presets values.
+   [u32 value](nr_total_params)            // total parameters defined by all used features.
+   [u16 value](nr_feat_refs)               // number of features referenced by the configuration
+   [u64 values] * (nr_presets * nr_total_params)     // the preset values.
+   [cscfg_table_elem_str] * (nr_feat_refs) // names of features used in the configurations.
+
+FEATURE_ELEM element
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_header]               // header length is total bytes to end of param structures.
+   [cscfg_table_elem_str]                  // feature name.
+   [cscfg_table_elem_str]                  // feature description.
+   [u32 value](match_flags)                // flags to associate the feature with a device.
+   [u16 value](nr_regs)                    // number of registers.
+   [u16 value](nr_params)                  // number of parameters.
+   [cscfg_regval_desc struct] * (nr_regs)  // register definitions
+   [PARAM_ELEM] * (nr_params)              // parameters definitions
+
+PARAM_ELEM element
+~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_str]        // parameter name.
+   [u64 value](param_value)      // initial value.
+
+Additional definitions
+~~~~~~~~~~~~~~~~~~~~~~
+
+The following structures are defined in ``coresight-config-file.h``
+
+ * ``struct cscfg_table_header`` : This structure contains an initial magic number, the total
+   length of the table, and the number of configurations and features in the table.
+ * ``struct cscfg_table_elem_header``: This defines the total length and type of a CONFIG_ELEM
+   or a FEATURE_ELEM.
+ * ``struct cscfg_table_elem_str``: This defines a string and its length.
+
+The magic number in cscfg_table_header is defined as two bitfields::
+
+   [31:8] Fixed magic number to identify table type.
+   [7:0]  Current table format version.
+
+The following defines determine the maximum overall table size and maximum individual
+string size
+
+ * ``CSCFG_TABLE_MAXSIZE``      : maximum overall table size.
+ * ``CSCFG_TABLE_STR_MAXSIZE``  : maximum individual string size.
+
+Load Dependencies
+~~~~~~~~~~~~~~~~~
+
+Files may be unloaded only in the strict reverse order of loading. This is enforced by the
+configuration system.
+
+This is to ensure that any load dependencies are maintained.
+
+A configuration table that contains a CONFIG_ELEM that references named features "feat_A" and "feat_B" will load only if either:-
+
+a) "feat_A" and/or "feat_B" has been loaded previously, or are present as built-in / module loaded features.
+b) "feat_A" and/or "feat_B" are declared as FEAT_ELEM in the same table as the CONFIG_ELEM.
+
+Tables that contain features or configurations with the same names as those already loaded will fail to load.
-- 
2.25.1


